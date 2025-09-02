import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "popup"];

  connect() {
    document.addEventListener("turbo:frame-load", () => {
      const modals = document.querySelectorAll(".modal");
      modals.forEach((modalEl) => {
        if (!bootstrap.Modal.getInstance(modalEl)) {
          new bootstrap.Modal(modalEl);
        }
      });
    });
  }

  markCompleted(event) {
    const audio = document.getElementById("complete-audio");

    // Change button text and disable it
    if (this.hasButtonTarget) {
      this.buttonTarget.textContent = "Completed";
      this.buttonTarget.disabled = true;
    }

    // Show modal and play audio
    if (this.hasPopupTarget) {
      const modal = new bootstrap.Modal(this.popupTarget);
      modal.show();
      audio.play();
    }
  }
}