function openModal(image) {
  const modal = document.getElementById("photoModal");
  const modalImage = document.getElementById("modalImage");
  modal.style.display = "block";
  modalImage.src = image.src; // サムネイル画像をモーダルに設定
}

// モーダルを閉じる関数
function closeModal() {
  const modal = document.getElementById("photoModal");
  modal.style.display = "none";
}