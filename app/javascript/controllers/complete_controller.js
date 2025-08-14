import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "popup"]

  markCompleted(event) {

    this.buttonTarget.textContent = "Completed";

    if (this.hasPopupTarget) {
      this.display();
    }
  }
  
  display() {
    this.popupTarget.style.display = "block";
    setTimeout(() => {
      this.close();
    }, 9000); 
  }

  close() {
    this.popupTarget.style.display = "none";
  }
}