import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="collapse"
export default class extends Controller {
  static targets = ["form", "suggested"]
  toggleForm() {
    const bsCollapse = new bootstrap.Collapse(this.formTarget, { toggle: false })
    const suggestedCollapse = new bootstrap.Collapse(this.suggestedTarget, { toggle: false })
    bsCollapse.toggle()
    suggestedCollapse.hide()
  }

  toggleSuggested() {
    const bsCollapse = new bootstrap.Collapse(this.formTarget, { toggle: false })
    const suggestedCollapse = new bootstrap.Collapse(this.suggestedTarget, { toggle: false })
    bsCollapse.hide()
    suggestedCollapse.toggle()
  }
}
