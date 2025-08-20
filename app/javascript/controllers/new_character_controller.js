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
    this.img = null
    if (this.hasImagePathValue) this.show()
  }

  render() {
    const gender = this.genderTargets?.find(r => r.checked)?.value
    const klass  = this.klassTargets?.find(r => r.checked)?.value
    if (!gender || !klass) return this.clearAnimation()

    const spritePath = `/assets/${gender.toLowerCase()}_${klass.toLowerCase()}.png`
    this.show(spritePath)
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

    if (!this.img) {
      this.img = document.createElement("img")
      this.img.id = "npc"
      this.img.alt = "character"
      Object.assign(this.img.style, {
        position: "absolute",
        top: "50%",
        left: "50%",
        transform: "translate(-50%, -50%)",
        objectFit: "none",
        imageRendering: "pixelated",
        pointerEvents: "none"
      })
      this.displayTarget.appendChild(this.img)
    }

    this.img.onload = () => {
      const sheetW = this.img.naturalWidth
      const sheetH = this.img.naturalHeight

      let totalFrames, frameW, frameH, cols, rows

      // Try to detect frame count
      const candidates = [16, 12, 10, 9, 8, 6, 5, 4, 3, 2]
      totalFrames = candidates.find(n => sheetW % n === 0) || 8

      frameW = Math.floor(sheetW / totalFrames)
      frameH = sheetH

      // ✅ Multi-row support
      if (frameW < frameH) {
        cols = Math.floor(sheetW / frameH)
        rows = Math.floor(sheetH / frameH)
        totalFrames = cols * rows
        frameW = frameH // make frames square
      } else {
        cols = totalFrames
        rows = 1
      }

      // Scale
      const widthPx  = Math.round(frameW * this.scaleValue)
      const heightPx = Math.round(frameH * this.scaleValue)
      this.img.style.width  = `${widthPx}px`
      this.img.style.height = `${heightPx}px`

      let currentFrame = 0
      const step = () => {
        const col = currentFrame % cols
        const row = Math.floor(currentFrame / cols)
        this.img.style.objectPosition = `-${col * frameW}px -${row * frameH}px`
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
    if (this.img) {
      this.img.style.objectPosition = "0px 0px"
      this.img.src = "" // clear broken image if no selection
    }
    this.currentSpritePath = null
  }

  disconnect() {
    this.clearAnimation()
  }
}