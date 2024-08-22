import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-points"
export default class extends Controller {
  static targets =["image"]

  showPoints() {
    // this.imageTarget.classList.toggle("d-none")
    // remove can be used instead of toggle
    // this.formTarget.classList.add("d-none")  // Hide the form
    const formElement = document.getElementById("form");
    formElement.classList.add("d-none");
    this.imageTarget.classList.remove("d-none") // Show the image


    // setTimeout(() => {
    //   window.location.href = "/tasks"; // Replace with the correct path
    // }, 5000)
  }
}
