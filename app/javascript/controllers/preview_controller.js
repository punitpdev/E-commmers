import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  showImage(event) {
    const file = event.target.files[0]
    console.log(file)
    if (!file) return

    const reader = new FileReader()
    reader.onload = (e) => {
      let previewImage = this.element.querySelector("img.preview-image")
      
      if (!previewImage) {
        previewImage = document.createElement("img")
        previewImage.classList.add("preview-image", "mt-4", "rounded-xl", "shadow-sm", "w-full", "max-h-60", "object-contain")
        this.element.appendChild(previewImage)
      }

      previewImage.src = e.target.result
    }

    reader.readAsDataURL(file)
  }
}
