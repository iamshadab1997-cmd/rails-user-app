// app/javascript/controllers/image_preview_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    this.previewTarget.innerHTML = "" // clear on load
  }

  preview() {
    this.previewTarget.innerHTML = "" // clear previous
    const files = this.inputTarget.files
    if (!files || files.length === 0) return

    Array.from(files).forEach(file => {
      const reader = new FileReader()
      reader.onload = (e) => {
        const img = document.createElement("img")
        img.src = e.target.result
        img.width = 150
        img.height = 150
        img.style.objectFit = "cover"
        img.style.marginRight = "10px"
        img.style.borderRadius = "8px"
        img.style.border = "1px solid #ccc"
        this.previewTarget.appendChild(img)
      }
      reader.readAsDataURL(file)
    })
  }
}
