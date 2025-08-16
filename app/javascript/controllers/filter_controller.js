import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ["item"]

  filter(event) {
    const categoryId = event.currentTarget.dataset.categoryId

    this.itemTargets.forEach(item => {
      if (categoryId === 'all' || item.dataset.categoryId === categoryId) {
        item.style.display = 'block'
      } else {
        item.style.display = 'none'
      }
    })
  }
}
