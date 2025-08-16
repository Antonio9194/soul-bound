import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "popup"]

  markCompleted(event) {
    // Submit the form to Rails
    const form = this.buttonTarget.closest("form")
    if (form) form.requestSubmit() 

    // Change button text
    if (this.hasButtonTarget) this.buttonTarget.textContent = "Completed"
    this.buttonTarget.disabled = true

    // Show Bootstrap modal
    if (this.hasPopupTarget) {
      const modal = new bootstrap.Modal(this.popupTarget)
      modal.show()
    }
  }
}