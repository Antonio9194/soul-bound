import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-character"
export default class extends Controller {
  static targets = ["appearance", "gender", "klass", "display"]

  connect(){
    console.log("this is the character controller")
  }

  render(event){
    console.log(event.target)

    const klass = this.klassTargets.find(radio => radio.checked)?.value || null
    const gender = this.genderTargets.find(radio => radio.checked)?.value || null
    const appearance = this.appearanceTargets.find(radio => radio.checked)?.value || null
    console.log(klass, gender, appearance)

    const basePath = this.displayTarget.dataset.baseImagePath

    const genderAppearance = `
      <img
        style="position: absolute"
        src="${basePath}ph${gender}${appearance}.png"
        alt="">
    `

    const klassTarget = `
      <img
        style="position: absolute"
        src="${basePath}${klass}.png"
        alt="">
    `

    this.displayTarget.innerHTML = `${genderAppearance}${klassTarget}`
  }
}
