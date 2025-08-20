// app/javascript/controllers/new_character_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gender", "klass", "display"]
  static values  = {
    imagePath: String,
    scale:    { type: Number, default: 1.5 },
    speed:    { type: Number, default: 200 }
  }

  connect() {
    this.timer = null
    this.currentSpritePath = null

    this.img = this.displayTarget.querySelector("#npc")
    if (!this.img) {
      this.img = document.createElement("img")
      this.img.id = "npc"
      this.img.alt = "character"
      Object.assign(this.img.style, {
        position: "absolute",
        top: "50%",
        left: "50%",
        transform: "translate(-50%, -55%)",
        objectFit: "none",
        imageRendering: "pixelated",
        pointerEvents: "none"
      })
      this.displayTarget.appendChild(this.img)
    }

    if (this.hasImagePathValue) this.show()
  }

  render() {
    const gender = this.genderTargets?.find(r => r.checked)?.value
    const klass  = this.klassTargets?.find(r => r.checked)?.value
    if (!gender || !klass) return this.clearAnimation()

    const spritePath = `/assets/${gender.toLowerCase()}_${klass.toLowerCase()}.png`
    this.renderSprite(spritePath)
  }

  show(path) {
    const spritePath = path || this.imagePathValue
    if (!spritePath) return
    this.renderSprite(spritePath)
  }

  renderSprite(spritePath) {
    if (spritePath === this.currentSpritePath) return
    this.currentSpritePath = spritePath
    this.clearAnimation()

    this.img.onload = () => {
      const sheetW = this.img.naturalWidth
      const sheetH = this.img.naturalHeight

      let totalFrames, frameW, frameH
      if (sheetH > 0 && sheetW % sheetH === 0) {
        totalFrames = Math.max(2, Math.min(48, sheetW / sheetH))
        frameW = sheetH
        frameH = sheetH
      } else {
        const candidates = [16, 12, 10, 9, 8, 6, 5, 4, 3, 2]
        totalFrames = candidates.find(n => sheetW % n === 0) || 8
        frameW = Math.floor(sheetW / totalFrames)
        frameH = sheetH
      }

      const widthPx  = Math.round(frameW * this.scaleValue)
      const heightPx = Math.round(frameH * this.scaleValue)
      this.img.style.width  = `${widthPx}px`
      this.img.style.height = `${heightPx}px`

      let currentFrame = 0
      const step = () => {
        this.img.style.objectPosition = `-${currentFrame * frameW}px 0px`
        currentFrame = (currentFrame + 1) % totalFrames
      }

      step()
      this.timer = setInterval(step, this.speedValue)
    }

    this.img.src = spritePath
  }

  clearAnimation() {
    if (this.timer) clearInterval(this.timer)
    this.timer = null
    if (this.img) this.img.style.objectPosition = "0px 0px"
  }

  disconnect() {
    this.clearAnimation()
  }
}