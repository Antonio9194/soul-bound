import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["display", "input", "text"];

  connect() {
    this.typeAndVanish(this.textTarget, "Click me to change the threads of time!", 60, 2000);
  }

  showInput() {
    this.displayTarget.style.display = "none";
    this.inputTarget.style.display = "block";
    this.inputTarget.querySelector("input").focus();
  }


  checkEnter(event) {
    if (event.key === "Enter") {
      event.preventDefault();
      this.inputTarget.querySelector("form")?.requestSubmit();
    }
  }
  

  //vanish text for timec hange

  typeAndVanish(element, message, speed, vanishDelay) {
    element.textContent = "";
    let i = 0;

    const typeInterval = setInterval(() => {
      element.textContent += message[i];
      i++;
      if (i === message.length) {
        clearInterval(typeInterval);
        setTimeout(() => {
          element.textContent = "";
        }, vanishDelay);
      }
    }, speed);
  }
}