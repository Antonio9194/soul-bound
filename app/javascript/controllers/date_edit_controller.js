// app/javascript/controllers/date_edit_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["clickme"];

  connect() {
    console.log("hi");
  }

  fire() {
    this.clickmeTarget.classList.fire("hidden");
  }
}