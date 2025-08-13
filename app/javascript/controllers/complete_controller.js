import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button"]

  markCompleted(event) {
    this.buttonTarget.textContent = "Completed";
    this.buttonTarget.disabled = true;
  }
}