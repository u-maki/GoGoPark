function initMap() {
  // 現在地を取得
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function (position) {
      var userLocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      // 地図の表示
      var map = new google.maps.Map(document.getElementById('map'), {
        center: userLocation,
        zoom: 14
      });

      // 現在地にマーカーを追加
      new google.maps.Marker({
        position: userLocation,
        map: map,
        title: "あなたの位置",
        icon: {
          url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png" // 青いアイコン
        }
      });

      // 初回検索
      searchParks(userLocation, map);

      // マップのドラッグ終了時に再検索を実行
      google.maps.event.addListener(map, "dragend", function () {
        var center = map.getCenter(); // 地図の中心座標を取得
        var newLocation = {
          lat: center.lat(),
          lng: center.lng()
        };
        searchParks(newLocation, map);
      });
    });
  } else {
    alert("位置情報が取得できません。");
  }
}

// 周辺の公園を検索する関数
function searchParks(location, map) {
  var service = new google.maps.places.PlacesService(map);
  var request = {
    location: location,
    radius: 5000, // 5km圏内
    type: ['park'] // 公園のみを検索
  };

  // 公園情報を取得
  service.nearbySearch(request, function (results, status) {
    updateParksList(results, status, map);
  });
}

function updateParksList(results, status, map) {
  var parksList = document.getElementById('parks-list');
  parksList.innerHTML = ""; // リストをクリア

  if (status === google.maps.places.PlacesServiceStatus.OK) {
    parksList.innerHTML = "<h2>近くの公園:</h2>"; // リストタイトル

    results.forEach((place) => {
      // 公園にマーカーを追加
      var parkMarker = new google.maps.Marker({
        position: place.geometry.location,
        map: map,
        title: place.name
      });

      // マーカークリック時に詳細ページに遷移
      parkMarker.addListener('click', function () {
        var detailUrl = `/parks/details/${place.place_id}`;
        window.location.href = detailUrl;
      });
      

      // 公園情報をリストに表示
      var parkItem = document.createElement('div');
      parkItem.classList.add('park-item');
      parkItem.innerHTML = `
        <h3>${place.name}</h3>
        <p>${place.vicinity ? place.vicinity : '住所情報はありません'}</p>
      `;

      // リストクリック時に詳細ページに遷移
      parkItem.addEventListener('click', function () {
        var detailUrl = `/parks/details/${place.place_id}`;
        window.location.href = detailUrl;
      });

      parksList.appendChild(parkItem);
    });
  } else {
    parksList.innerHTML = "<p>周辺の公園情報を取得できませんでした。</p>";
    console.error("Google Places API エラー: ", status);
  }
}

document.addEventListener("DOMContentLoaded", initMap);
