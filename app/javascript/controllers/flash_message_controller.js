import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash-message"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.close()
    }, 3000)
  }

  close() {
    this.element.classList.add('opacity-0', 'transition-opacity', 'duration-500')
    setTimeout(() => {
      this.element.remove()
    }, 500)
  }
}
