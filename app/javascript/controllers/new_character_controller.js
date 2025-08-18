import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gender", "appearance", "klass", "display"]

  render() {
    const gender = this.genderTargets.find(r => r.checked)?.value
    const appearance = this.appearanceTargets.find(r => r.checked)?.value
    const klass = this.klassTargets.find(r => r.checked)?.value

    if (!gender || !appearance || !klass) {
      this.displayTarget.innerHTML = ""
      return
    }

    const appearancePath = `/assets/ph${gender}${appearance}.png`
    const classPath = `/assets/${klass}.png`

    this.displayTarget.innerHTML = `
      <img src="${appearancePath}" alt="Character Appearance" style="position: absolute; width: 160px; height: auto;" />
      <img src="${classPath}" alt="${klass}" style="position: absolute; width: 160px; height: auto;" />
    `
  }
}