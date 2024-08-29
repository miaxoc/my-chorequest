// app/javascript/controllers/water_plant_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["bud", "flower"]

  water() {
    console.log("clicked")
    console.log("Bud Target:", this.budTarget);
    console.log("Flower Target:", this.flowerTarget);

    // hide bud
    this.budTargets.forEach(bud => bud.classList.add('d-none'))

    // show flower
    // this.flowerTarget.classList.remove('d-none')
    this.flowerTargets.forEach(flower => flower.classList.remove('d-none'))
  }
}
