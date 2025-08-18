import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gender", "appearance", "klass", "display"]

  render() {
    const gender = this.genderTargets.find(r => r.checked)?.value
    const appearance = this.appearanceTargets.find(r => r.checked)?.value
    const klass = this.klassTargets.find(r => r.checked)?.value

    if (!gender || !appearance || !klass) return

    const fileName = `${klass}.png`
    const imgPath = `/assets/${fileName}`

    this.displayTarget.innerHTML = `<img src="${imgPath}" alt="${klass}" style="width: 100%; height: auto;" />`
  }
}