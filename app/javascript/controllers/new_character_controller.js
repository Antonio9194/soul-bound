import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gender", "klass", "display", "canvas"]
  static values = { show: Boolean } // true for show page

  connect() {
    if (this.hasCanvasTarget) {
      if (this.showValue) {
        this.renderShow()
      } else {
        this.render() // live preview for new.html
      }
    }
  }

  render() {
    const gender = this.genderTargets.find(r => r.checked)?.value
    const klass = this.klassTargets.find(r => r.checked)?.value
    if (!gender || !klass) return this.clearCanvas()

    this.renderSprite(gender, klass)
  }

  renderShow() {
    const gender = "<%= @character.gender %>"
    const klass = "<%= @character.class_name %>"
    this.renderSprite(gender, klass)
  }

  clearCanvas() {
    const ctx = this.canvasTarget.getContext("2d")
    ctx.clearRect(0, 0, this.canvasTarget.width, this.canvasTarget.height)
  }

  renderSprite(gender, klass) {
    const canvas = this.canvasTarget
    const ctx = canvas.getContext("2d")

    // Map gender + class to sprite
    let spritePath = ""
    if (gender === "Male" && klass === "Warrior") spritePath = "/assets/male_warrior.png"
    else if (gender === "Female" && klass === "Warrior") spritePath = "/assets/female_warrior.png"
    else if (gender === "Male" && klass === "Mage") spritePath = "/assets/male_mage.png"
    else if (gender === "Female" && klass === "Mage") spritePath = "/assets/female_mage.png"
    else if (gender === "Male" && klass === "Archer") spritePath = "/assets/male_archer.png"
    else if (gender === "Female" && klass === "Archer") spritePath = "/assets/female_archer.png"

    const sprite = new Image()
    sprite.src = spritePath

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