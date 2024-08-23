import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-points"
export default class extends Controller {
  static targets =["image"]

  showPoints() {

    const formElement = document.getElementById("form");
    formElement.classList.add("d-none");
    this.imageTarget.classList.remove("d-none")


    // setTimeout(() => {
    //   window.location.href = "/tasks"; // Replace with the correct path
    // }, 5000)
  }
}
