// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal" ]

  connect() {
    // 初回訪問ユーザー向けに自動表示するロジック（オプション）
    // if (!localStorage.getItem('tutorial_viewed')) {
    //   this.open();
    // }
  }

  // モーダルを開く
  open() {
    this.modalTarget.classList.remove('hidden');
    // 背景のスクロールを禁止
    document.body.classList.add('overflow-hidden');
  }

  // モーダルを閉じる
  close() {
    this.modalTarget.classList.add('hidden');
    // 背景のスクロール禁止を解除
    document.body.classList.remove('overflow-hidden');
    // 一度表示したらフラグを立てるロジック（オプション）
    // localStorage.setItem('tutorial_viewed', 'true');
  }

  // Escキーでモーダルを閉じる
  handleKeydown(event) {
    if (event.key === "Escape") {
      this.close();
    }
  }
}
