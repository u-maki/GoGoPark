// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

function initMap() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      function (position) {
        var userLocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude,
        };

        var map = new google.maps.Map(document.getElementById("map"), {
          center: userLocation,
          zoom: 14,
        });

        new google.maps.Marker({
          position: userLocation,
          map: map,
          title: "あなたの位置",
        });

        var service = new google.maps.places.PlacesService(map);
        var request = {
          location: userLocation,
          radius: 5000,
          type: ["park"],
        };

        service.nearbySearch(request, function (results, status) {
          if (status === google.maps.places.PlacesServiceStatus.OK) {
            displayParks(results, map);
          } else {
            alert("公園情報の取得に失敗しました: " + status);
          }
        });
      },
      function (error) {
        alert("位置情報の取得に失敗しました: " + error.message);
      }
    );
  } else {
    alert("このブラウザでは位置情報を利用できません。");
  }
}

function displayParks(parks, map) {
  var parksList = document.getElementById("parks-list");
  parksList.innerHTML = "<h2>近くの公園:</h2>";

  parks.forEach(function (place) {
    var parkMarker = new google.maps.Marker({
      position: place.geometry.location,
      map: map,
      title: place.name,
    });

    parkMarker.addListener("click", function () {
      if (place.place_id) {
        // URLをRailsのルーティングに合わせる
        var detailUrl = `/parks/details/${place.place_id}`;
        window.location.href = detailUrl;
      } else {
        alert("公園の詳細情報が取得できませんでした。");
      }
    });

    // 公園情報をリストに表示
    var parkItem = document.createElement("div");
    parkItem.classList.add("park-item");
    parkItem.innerHTML = `
      <h3>${sanitizeHtml(place.name)}</h3>
      <p>${sanitizeHtml(place.vicinity || "住所情報はありません")}</p>
    `;
    parksList.appendChild(parkItem);
  });
}

function sanitizeHtml(str) {
  var div = document.createElement("div");
  div.appendChild(document.createTextNode(str));
  return div.innerHTML;
}

window.onload = initMap;
