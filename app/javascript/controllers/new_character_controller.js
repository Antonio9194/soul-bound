import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gender", "appearance", "klass", "display"]

  render() {
    const gender = this.genderTargets.find(r => r.checked)?.value
    const appearance = this.appearanceTargets.find(r => r.checked)?.value
    const klass = this.klassTargets.find(r => r.checked)?.value
    if (!gender || !appearance || !klass) return

    const basePath = this.displayTarget.dataset.baseImagePath

    this.displayTarget.innerHTML = `
      <img src="${basePath}ph${gender}${appearance}.png" alt="Character" style="position: absolute; width: 160px; height: auto;" />
      <img src="${basePath}${klass}.png" alt="${klass}" style="position: absolute; width: 160px; height: auto;" />
    `
  }
}