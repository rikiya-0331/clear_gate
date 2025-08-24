import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="qa-card"
export default class extends Controller {
  static targets = [ "japanese", "button" ]

  toggle() {
    this.japaneseTarget.classList.toggle("hidden")

    if (this.japaneseTarget.classList.contains("hidden")) {
      this.buttonTarget.textContent = "日本語訳を見る"
    } else {
      this.buttonTarget.textContent = "日本語訳を隠す"
    }
  }
}