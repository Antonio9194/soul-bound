// app/javascript/controllers/new_character_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gender", "klass", "display"]
  static values  = { imagePath: String, scale: { type: Number, default: 0.9 } }

  connect() {
    this.animationInterval = null
    this.currentSpritePath = null

    // use existing canvas if present, otherwise create one
    this.canvas = this.displayTarget.querySelector("#characterCanvas")
    if (!this.canvas) {
      this.canvas = document.createElement("canvas")
      this.canvas.id = "characterCanvas"
      this.canvas.width = 256
      this.canvas.height = 256
      this.canvas.style.position = "absolute"
      this.canvas.style.top = "0"
      this.canvas.style.left = "0"
      this.displayTarget.appendChild(this.canvas)
    }
    this.ctx = this.canvas.getContext("2d")

    // DPR setup (crisp pixels)
    const dpr = window.devicePixelRatio || 1
    const cssW = this.canvas.width
    const cssH = this.canvas.height
    this.canvas.style.width = cssW + "px"
    this.canvas.style.height = cssH + "px"
    this.canvas.width  = Math.round(cssW * dpr)
    this.canvas.height = Math.round(cssH * dpr)
    this.ctx.setTransform(dpr, 0, 0, dpr, 0, 0)
    this.ctx.imageSmoothingEnabled = false

    if (this.hasImagePathValue) this.show() // for show page
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

    if (this.animationInterval) clearInterval(this.animationInterval)
    if (this._raf) cancelAnimationFrame(this._raf)

    const sprite = new Image()
    sprite.src = spritePath

    sprite.onload = () => {
      const imgW = sprite.naturalWidth
      const imgH = sprite.naturalHeight

      // Infer frames
      let totalFrames, frameWidth, frameHeight
      if (imgH > 0 && imgW % imgH === 0) {
        totalFrames = Math.max(2, Math.min(24, imgW / imgH))
        frameWidth  = imgH
        frameHeight = imgH
      } else {
        const candidates = [12, 10, 9, 8, 6, 5, 4, 3, 2]
        totalFrames = candidates.find(n => imgW % n === 0) || 8
        frameWidth  = Math.floor(imgW / totalFrames)
        frameHeight = imgH
      }

      // Center + scale to fit
      const dpr = window.devicePixelRatio || 1
      const cssW = this.canvas.width  / dpr
      const cssH = this.canvas.height / dpr
      const fitScale = Math.min(cssW / frameWidth, cssH / frameHeight)
      const scale = fitScale * this.scaleValue
      const destW = frameWidth  * scale
      const destH = frameHeight * scale
      const destX = (cssW - destW) / 2
      const destY = (cssH - destH) / 2

      let currentFrame = 0
      let last = 0
      const msPerFrame = 220

      const tick = (t) => {
        if (!last) last = t
        if (t - last >= msPerFrame) {
          last = t
          this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height)
          this.ctx.drawImage(
            sprite,
            currentFrame * frameWidth, 0, frameWidth, frameHeight,
            destX, destY, destW, destH
          )
          currentFrame = (currentFrame + 1) % totalFrames
        }
        this._raf = requestAnimationFrame(tick)
      }
      this._raf = requestAnimationFrame(tick)
    }
  }

  clearAnimation() {
    if (this.animationInterval) clearInterval(this.animationInterval)
    if (this._raf) cancelAnimationFrame(this._raf)
    if (this.ctx && this.canvas) this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height)
    this.animationInterval = null
    this._raf = null
    this.currentSpritePath = null
  }

  disconnect() {
    if (this.animationInterval) clearInterval(this.animationInterval)
    if (this._raf) cancelAnimationFrame(this._raf)
  }
}