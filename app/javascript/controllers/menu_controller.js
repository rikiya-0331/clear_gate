// app/javascript/controllers/menu_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "button"]

  connect() {
    console.log("Menu controller connected!");
    this.updateMenuVisibility(); // 初期状態を設定するため
  }

  toggle() {
    console.log("Toggle method called!");
    // menuTargetにhiddenクラスをトグルする
    this.menuTarget.classList.toggle("hidden");
    // menuTargetにflexクラスをトグルする (モバイル時に縦並び表示用)
    this.menuTarget.classList.toggle("flex");
  }

  // 画面サイズ変更時にメニューの表示状態を更新する
  updateMenuVisibility() {
    if (window.innerWidth >= 1024) { // Tailwindのlgブレークポイント (PCサイズ)
      // PCサイズではメニューを常に表示し、モバイル用の隠しクラスを解除
      this.menuTarget.classList.remove("hidden");
      this.menuTarget.classList.add("flex"); // PCではflex表示
    } else { // モバイルサイズ
      // モバイルサイズではメニューを隠す（初期状態）
      this.menuTarget.classList.add("hidden");
      this.menuTarget.classList.remove("flex"); // モバイルではflexを解除（hiddenとflexは排他的なため）
    }
  }

  // 画面リサイズイベントを監視
  resize() {
    console.log("Resize method called!");
    this.updateMenuVisibility();
  }
}