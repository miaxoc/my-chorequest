import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-points"
export default class extends Controller {
  static targets =["image", "form"]

  showPoints() {
    console.log("connected")
    this.formTarget.classList.add("d-none");
    this.imageTarget.classList.remove("d-none")


    // setTimeout(() => {
    //   window.location.href = "/tasks"; // Replace with the correct path
    // }, 5000)
  }
}
