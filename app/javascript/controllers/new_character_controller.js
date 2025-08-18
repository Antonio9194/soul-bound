export default class NewCharacterController {
  static targets = ["apperance", "gender", "klass", "display"]

  render() {
    const klass = this.klassTargets.find(radio => radio.checked)?.value
    const gender = this.genderTargets.find(radio => radio.checked)?.value
    const apperance = this.apperanceTargets.find(radio => radio.checked)?.value

    const basePath = this.displayTarget.dataset.baseImagePath

    let genderApperance = ""
    if (gender && apperance) {
      genderApperance = `
        <img style="position: absolute" src="${basePath}ph${gender}${apperance}.png" alt="">
      `
    }

    let klassTarget = ""
    if (klass) {
      klassTarget = `
        <img style="position: absolute" src="${basePath}${klass}.png" alt="">
      `
    }

    this.displayTarget.innerHTML = `${genderApperance}${klassTarget}`
  }
}