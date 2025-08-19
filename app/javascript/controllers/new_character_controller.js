import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gender", "klass", "display"]

  render() {
    const gender = this.genderTargets.find(r => r.checked)?.value
    const klass = this.klassTargets.find(r => r.checked)?.value

    const canvas = this.displayTarget.querySelector("#preview-canvas")
    const ctx = canvas.getContext("2d")

    // Clear canvas if no selection
    if (!gender || !klass) {
      ctx.clearRect(0, 0, canvas.width, canvas.height)
      return
    }

    // Map combinations to PNG
    let spritePath = ""
    if (gender === "Male" && klass === "Warrior") spritePath = "/assets/male_warrior.png"
    else if (gender === "Female" && klass === "Warrior") spritePath = "/assets/female_warrior.png"
    else if (gender === "Male" && klass === "Mage") spritePath = "/assets/male_mage.png"
    else if (gender === "Female" && klass === "Mage") spritePath = "/assets/female_mage.png"
    else if (gender === "Male" && klass === "Archer") spritePath = "/assets/male_archer.png"
    else if (gender === "Female" && klass === "Archer") spritePath = "/assets/female_archer.png"

    const sprite = new Image()
    sprite.src = spritePath

    const totalFrames = 8        // frames per animation
    const frameWidth = 96        // frame width in PNG
    const frameHeight = 64       // frame height in PNG
    const row = 0                // idle row (first row)
    let currentFrame = 0

    sprite.onload = () => {
      // Stop previous animation if exists
      if (this.animationInterval) clearInterval(this.animationInterval)

      this.animationInterval = setInterval(() => {
        ctx.clearRect(0, 0, canvas.width, canvas.height)
        ctx.drawImage(
          sprite,
          currentFrame * frameWidth, row * frameHeight, // source x, y
          frameWidth, frameHeight,                      // source width, height
          0, 0,                                         // destination x, y
          canvas.width, canvas.height                   // destination width, height
        )
        currentFrame = (currentFrame + 1) % totalFrames
      }, 200)
    }
  }
}