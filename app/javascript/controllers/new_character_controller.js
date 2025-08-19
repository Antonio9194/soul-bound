import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gender", "appearance", "klass", "display"]

  render() {
  const gender = this.genderTargets.find(r => r.checked)?.value
  const appearance = this.appearanceTargets.find(r => r.checked)?.value
  const klass = this.klassTargets.find(r => r.checked)?.value

  const canvas = this.displayTarget.querySelector("#preview-canvas")
  const ctx = canvas.getContext("2d")

  if (!gender || !appearance || !klass) {
    ctx.clearRect(0, 0, canvas.width, canvas.height)
    return
  }

  const sprite = new Image()
  sprite.src = `/assets/ph${gender}${appearance}.png` // your horizontal sprite sheet

  const totalFrames = 8
  const frameWidth = 96
  const frameHeight = 64
  let currentFrame = 0

  sprite.onload = () => {
    if (this.animationInterval) clearInterval(this.animationInterval)
    this.animationInterval = setInterval(() => {
      ctx.clearRect(0, 0, canvas.width, canvas.height)
      ctx.drawImage(sprite, currentFrame * frameWidth, 0, frameWidth, frameHeight,
                    0, 0, canvas.width, canvas.height)
      currentFrame = (currentFrame + 1) % totalFrames
    }, 200)
  }
}
}