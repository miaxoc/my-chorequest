// app/javascript/controllers/image_animation_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["image"]

  connect() {
    const rawImagesData = this.data.get("images")
    const decodedImagesData = rawImagesData.replace(/&quot;/g, '"')
    try {
      this.images = JSON.parse(decodedImagesData || "[]")
    } catch (error) {
      console.error("Error parsing data-image-animation-images attribute:", error)
      this.images = []
    }

    this.currentIndex = 0
    this.startAnimation()
  }

  startAnimation() {
    this.interval = setInterval(() => {
      this.currentIndex = (this.currentIndex + 1) % this.images.length
      this.imageTarget.src = this.images[this.currentIndex]
    }, 500) // Change image every 0.5 seconds
  }

  disconnect() {
    clearInterval(this.interval)
  }
}
