import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gender", "klass", "display"]

  render() {
    const gender = this.genderTargets.find(r => r.checked)?.value
    const klass  = this.klassTargets.find(r => r.checked)?.value
    const display = this.displayTarget

    if (!gender || !klass) {
      display.innerHTML = ""
      return
    }

    const path = `/assets/${gender.toLowerCase()}_${klass.toLowerCase()}.png`

    display.innerHTML = `
      <img id="npc-preview"
           src="${path}"
           style="
             position: absolute;
             top: 50%;
             left: 50%;
             transform: translate(-50%, -50%) scale(2);
             transform-origin: center;
             width: 86px;
             height: 86px;
             object-fit: none;
             object-position: 0 0;
             image-rendering: pixelated;
             pointer-events: none;" />
    `
  }
}