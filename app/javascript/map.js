let map;
let circle;
let pin;
let markers = [];

function initMap() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition((position) => {
      const userLocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
      };

      // 地図の初期化
      map = new google.maps.Map(document.getElementById("map"), {
        center: userLocation,
        zoom: 14,
      });

      // サークルの作成
      circle = new google.maps.Circle({
        map: map,
        center: userLocation,
        radius: 1000, // 半径1キロ
        strokeColor: "#FF0000",
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: "#FF0000",
        fillOpacity: 0.35,
      });

      // ピン（現在地）を作成
      pin = new google.maps.Marker({
        position: userLocation,
        map: map,
        title: "検索範囲の中心",
        icon: {
          url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png",
        },
      });

      // 初回検索
      filterSearch();

      // マップのドラッグ終了時に検索を更新
      google.maps.event.addListener(map, "dragend", debounce(updateSearch, 300));
    });
  } else {
    alert("位置情報が取得できません。");
  }
}

function updateSearch() {
  // ピンとサークルを中央に合わせる
  const center = map.getCenter();
  pin.setPosition(center);
  circle.setCenter(center);

  // 新しい中心で検索を更新
  filterSearch();
}

function filterSearch() {
  const center = circle.getCenter();
  const radius = circle.getRadius();

  // Google Places APIを使用して範囲内の公園を検索
  const service = new google.maps.places.PlacesService(map);
  const request = {
    location: center,
    radius: radius,
    type: ["park"],
  };

  // 既存のマーカーを削除
  clearMarkers();

  service.nearbySearch(request, (results, status) => {
    if (status === google.maps.places.PlacesServiceStatus.OK) {
      results.forEach((place) => {
        const marker = new google.maps.Marker({
          position: place.geometry.location,
          map: map,
          title: place.name,
        });

        markers.push(marker);
      });
    } else {
      console.error("Google Places API エラー: ", status);
    }
  });
}

function clearMarkers() {
  markers.forEach((marker) => marker.setMap(null));
  markers = [];
}

// デバウンス関数（リクエストを間引くため）
function debounce(func, wait) {
  let timeout;
  return function (...args) {
    const context = this;
    clearTimeout(timeout);
    timeout = setTimeout(() => func.apply(context, args), wait);
  };
}

document.addEventListener("DOMContentLoaded", initMap);
