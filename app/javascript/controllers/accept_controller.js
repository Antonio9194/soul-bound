import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="accept"
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

  markAccepted(event) {
    const btn = this.buttonTarget;
    btn.innerText = "Accepted";
    btn.disabled = true;
    btn.classList.remove("text-active");
    btn.classList.add("text-completed");

    const audio = document.getElementById("complete-audio");

    if (this.hasPopupTarget) {
      const modal = new bootstrap.Modal(this.popupTarget);
      modal.show();
      audio.play();
    }
  }
}