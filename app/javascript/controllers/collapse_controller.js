import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

// Connects to data-controller="collapse"
export default class extends Controller {
  static targets = ["form", "suggested"]
  toggle() {
    console.log(bootstrap)
    
  }
}
