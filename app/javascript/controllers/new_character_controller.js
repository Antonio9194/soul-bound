import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gender", "klass", "display"]

  connect() {
    this.animationInterval = null
  }

  render() {
    const gender = this.genderTargets.find(r => r.checked)?.value
    const klass = this.klassTargets.find(r => r.checked)?.value

    if (!gender || !klass) {
      this.displayTarget.innerHTML = ""
      if (this.animationInterval) clearInterval(this.animationInterval)
      return
    }

    let spritePath = ""
    if (gender === "Male" && klass === "Warrior") spritePath = "/assets/male_warrior.png"
    else if (gender === "Female" && klass === "Warrior") spritePath = "/assets/female_warrior.png"
    else if (gender === "Male" && klass === "Mage") spritePath = "/assets/male_mage.png"
    else if (gender === "Female" && klass === "Mage") spritePath = "/assets/female_mage.png"
    else if (gender === "Male" && klass === "Archer") spritePath = "/assets/male_archer.png"
    else if (gender === "Female" && klass === "Archer") spritePath = "/assets/female_archer.png"

    // Make canvas a bit bigger to comfortably fit scaled sprite
    const canvasSize = 128
    this.displayTarget.innerHTML = `<canvas width="${canvasSize}" height="${canvasSize}"></canvas>`
    const canvas = this.displayTarget.querySelector("canvas")
    const ctx = canvas.getContext("2d")

    const sprite = new Image()
    sprite.src = spritePath

    const totalFrames = 12
    const frameWidth = 64
    const frameHeight = 64
    let currentFrame = 0

    sprite.onload = () => {
      if (this.animationInterval) clearInterval(this.animationInterval)

      const scale = 1.3  // double size
      const destWidth = frameWidth * scale
      const destHeight = frameHeight * scale
      const destX = (canvas.width - destWidth) / 2
      const destY = (canvas.height - destHeight) / 2

      // Slower, smoother animation
      this.animationInterval = setInterval(() => {
        ctx.clearRect(0, 0, canvas.width, canvas.height)
        ctx.drawImage(
          sprite,
          currentFrame * frameWidth, 0, frameWidth, frameHeight,
          destX, destY, destWidth, destHeight
        )
        currentFrame = (currentFrame + 1) % totalFrames
      }, 260) // 180ms per frame = slower, more visible
    }
  }

  disconnect() {
    if (this.animationInterval) clearInterval(this.animationInterval)
  }
}