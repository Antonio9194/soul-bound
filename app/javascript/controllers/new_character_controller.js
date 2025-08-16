import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-character"
export default class extends Controller {
  static targets = ["appearance", "gender", "klass", "display"]

  render(event) {
  const klass = this.klassTargets.find(radio => radio.checked)?.value
  const gender = this.genderTargets.find(radio => radio.checked)?.value
  const appearance = this.appearanceTargets.find(radio => radio.checked)?.value

  const basePath = this.displayTarget.dataset.baseImagePath

  let genderAppearance = ""
  if (gender && appearance) {
    genderAppearance = `
      <img style="position: absolute" src="${basePath}ph${gender}${appearance}.png" alt="">
    `
  }

  let klassTarget = ""
  if (klass) {
    klassTarget = `
      <img style="position: absolute" src="${basePath}${klass}.png" alt="">
    `
  }

  this.displayTarget.innerHTML = `${genderAppearance}${klassTarget}`
}
}
