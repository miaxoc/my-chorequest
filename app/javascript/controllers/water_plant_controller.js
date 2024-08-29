// app/javascript/controllers/water_plant_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["bud1", "flower1", "bud5", "flower5"]

  water() {
    console.log("clicked")
    console.log("Bud Target:", this.budTarget);
    console.log("Flower Target:", this.flowerTarget);

    if (confirm("Spend 5 water?")) {
    // hide bud
    this.bud1Targets.forEach(bud => bud.classList.add('d-none'))

    // show flower
    // this.flowerTarget.classList.remove('d-none')
    this.flower1Targets.forEach(flower => flower.classList.remove('d-none'))
    }

  }

  waterFive() {
    // hide bud
    this.bud5Targets.forEach(bud => bud.classList.add('d-none'))

    // show flower
    // this.flowerTarget.classList.remove('d-none')
    this.flower5Targets.forEach(flower => flower.classList.remove('d-none'))
  }
}
