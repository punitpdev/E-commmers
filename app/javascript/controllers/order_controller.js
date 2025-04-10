import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggleDetails(event) {
    const row = this.element
    const detailsRow = row.nextElementSibling
    if (detailsRow && detailsRow.classList.contains('order-details-row')) {
      detailsRow.classList.toggle('hidden')
    }
  }
}
