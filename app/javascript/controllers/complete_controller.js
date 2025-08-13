import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button"]

  markCompleted(event) {
    event.preventDefault();

    const url = this.buttonTarget.dataset.url;

    fetch(url, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ quest: { completed: true } })
    }).then(response => {
      if (response.ok) {
        this.buttonTarget.textContent = "Completed";
        this.buttonTarget.disabled = true;
      }
    });
  }
}
