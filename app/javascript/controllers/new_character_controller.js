export default class NewCharacterController {
  static targets = ["apperance", "gender", "klass", "display"]

  render() {
  const klass = this.klassTargets.find(radio => radio.checked)?.value
  const gender = this.genderTargets.find(radio => radio.checked)?.value
  const apperance = this.apperanceTargets.find(radio => radio.checked)?.value

  let genderKey = gender && apperance ? `ph${gender.toLowerCase()}${apperance}` : null
  let klassKey = klass ? klass.toLowerCase() : null

 let genderImg = genderKey ? `<img style="position:absolute; width:160px; height:auto;" src="${this.displayTarget.dataset[genderKey]}" alt="">` : ""
 let klassImg = klassKey ? `<img style="position:absolute; width:160px; height:auto;" src="${this.displayTarget.dataset[klassKey]}" alt="">` : ""

  this.displayTarget.innerHTML = `${genderImg}${klassImg}`
}
}