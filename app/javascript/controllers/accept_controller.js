import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accept"
export default class extends Controller {
  static targets = ["button", "popup"]

  markAccepted(event) { 

    const btn = this.buttonTarget
    btn.innerText = "Accepted"
    btn.disabled = true
    btn.classList.remove("text-active")
    btn.classList.add("text-completed")
     // Submit the form to Rails
    const audio = document.getElementById("complete-audio")

    // Show Bootstrap modal
    if (this.hasPopupTarget) {
      const modal = new bootstrap.Modal(this.popupTarget)
      modal.show()
      audio.play()
    }
  }
}