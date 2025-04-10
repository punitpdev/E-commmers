import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="variants"
export default class extends Controller {
  static targets = []

  add(event) {
    event.preventDefault()
    const content = document.createElement("div")
    const time = new Date().getTime()
    const template = document.getElementById("variant_template").innerHTML.replace(/TEMPLATE_RECORD/g, time)
    content.innerHTML = template
    console.log
    this.element.querySelector("#variants").appendChild(content)
  }

  remove(event) {
    event.preventDefault()
    const field = event.target.closest(".variant-fields")
    const destroyField = field.querySelector("input[name*='_destroy']")
    if (destroyField) {
      destroyField.value = "1"
      field.style.display = "none"
    }
  }
}
