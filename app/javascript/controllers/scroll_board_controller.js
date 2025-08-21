import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.style.transform = "translateY(-100%)"
    this.element.style.transition = "transform 1s ease-out"
    requestAnimationFrame(() => {
      this.element.style.transform = "translateY(0)"
    })
  }
}
