function initMap() {
  // 現在地を取得
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function (position) {
      const userLocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
      };

      // 地図の表示
      const map = new google.maps.Map(document.getElementById("map"), {
        center: userLocation,
        zoom: 14,
      });

      // 現在地に青いマーカーを追加
      new google.maps.Marker({
        position: userLocation,
        map: map,
        title: "あなたの位置",
        icon: {
          url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png", // 青いアイコン
        },
      });

      // 初回検索
      searchParks(userLocation, map);

      // マップのドラッグ終了時に再検索を実行
      google.maps.event.addListener(map, "dragend", function () {
        const center = map.getCenter(); // 地図の中心座標を取得
        const newLocation = {
          lat: center.lat(),
          lng: center.lng(),
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
  const service = new google.maps.places.PlacesService(map);
  const request = {
    location: location,
    radius: 5000, // 5km圏内
    type: ["park"], // 公園のみを検索
  };

  // 公園情報を取得
  service.nearbySearch(request, function (results, status) {
    updateParksList(results, status, map, location);
  });
}

// 公園リストを更新する関数
function updateParksList(results, status, map, userLocation) {
  const parksList = document.getElementById("parks-list");
  parksList.innerHTML = ""; // リストをクリア

  if (status === google.maps.places.PlacesServiceStatus.OK) {
    parksList.innerHTML = "<h2>近くの公園:</h2>"; // リストタイトル

    results.forEach((place) => {
      // 公園に緑色のマーカーを追加
      const parkMarker = new google.maps.Marker({
        position: place.geometry.location,
        map: map,
        title: place.name,
        icon: {
          url: "http://maps.google.com/mapfiles/ms/icons/green-dot.png", // 緑のアイコン
        },
      });

 // マーカークリック時に詳細ページに遷移
 parkMarker.addListener('click', function () {
  var detailUrl = `/parks/${place.place_id}`;
  window.location.href = detailUrl; // 公園詳細ページに遷移
});


 // 距離を計算
      const distance = calculateDistance(
        userLocation.lat,
        userLocation.lng,
        place.geometry.location.lat(),
        place.geometry.location.lng()
      );

 // 公園情報をリストに表示
      const parkItem = document.createElement("div");
      parkItem.classList.add("park-item");
      parkItem.innerHTML = `
        <h3>${place.name}</h3>
        <p>${place.vicinity ? place.vicinity : "住所情報はありません"}</p>
        <p>距離: ${distance.toFixed(2)} km</p>
      `;
  // リストクリック時に詳細ページに遷移
      parkItem.addEventListener("click", function () {
        const detailUrl = `/parks/${place.place_id}`;
        window.location.href = detailUrl;
      });

      parksList.appendChild(parkItem);
    });
  } else {
    parksList.innerHTML = "<p>周辺の公園情報を取得できませんでした。</p>";
    console.error("Google Places API エラー: ", status);
  }
}

// 2地点間の距離を計算する関数（Haversine formula）
function calculateDistance(lat1, lng1, lat2, lng2) {
  const R = 6371; // 地球の半径 (km)
  const dLat = ((lat2 - lat1) * Math.PI) / 180;
  const dLng = ((lng2 - lng1) * Math.PI) / 180;
  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos((lat1 * Math.PI) / 180) *
      Math.cos((lat2 * Math.PI) / 180) *
      Math.sin(dLng / 2) *
      Math.sin(dLng / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return R * c;
}

document.addEventListener("DOMContentLoaded", initMap);
