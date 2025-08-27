import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["preview", "gender"]
  static values = {
    maleWarrior: String,
    femaleWarrior: String,
    maleMage: String,
    femaleMage: String,
    maleWerewolf: String,
    femaleWerewolf: String,
    maleVampire: String,
    femaleVampire: String
  }

  connect() {
    this.interval = null
  }

  disconnect() {
    clearInterval(this.interval)
  }

  render() {
    const klass = document.querySelector('input[name="character[class_name]"]:checked')?.value?.toLowerCase()
    const gender = document.querySelector('input[name="character[gender]"]:checked')?.value?.toLowerCase()
    const preview = this.previewTarget

    // Disable gender selection if class is gorgon
    this.genderTargets.forEach(input => {
      input.disabled = klass === "gorgon"
    })

    // Determine key for sprite
    const key = klass === "gorgon" ? "gorgon" : `${gender}_${klass}`
    const sprite = this.spriteData[key]

    if (!sprite) {
      preview.style.display = "none"
      clearInterval(this.interval)
      return
    }

    const { path, frames, frameWidth, frameHeight, offsetX, speed } = sprite
    let currentFrame = 0

    preview.style.display = "block"
    preview.style.width = `${frameWidth}px`
    preview.style.height = `${frameHeight}px`
    preview.style.backgroundImage = `url(${path})`

    clearInterval(this.interval)
    this.interval = setInterval(() => {
      const xOffset = (frameWidth * currentFrame) - (offsetX?.[currentFrame] || 0)
      preview.style.backgroundPosition = `-${xOffset}px 0px`
      currentFrame = (currentFrame + 1) % frames
    }, speed || 170)
  }

  get spriteData() {
    return {
      "male_warrior": {
        path: this.maleWarriorValue,
        frames: 5,
        frameWidth: 86,
        frameHeight: 86,
        offsetX: [0, 0, 0, 0, 0],
        speed: 170
      },
      "female_warrior": {
        path: this.femaleWarriorValue,
        frames: 9,
        frameWidth: 100,
        frameHeight: 64,
        offsetX: [0, 0, 0, 0, 0],
        speed: 170
      },
      "female_mage": {
        path: this.femaleMageValue,
        frames: 10,
        frameWidth: 128,
        frameHeight: 128,
        offsetX: [0, 0, 0, 0, 0],
        speed: 120
      },
      "male_mage": {
        path: this.maleMageValue,
        frames: 16,
        frameWidth: 128,
        frameHeight: 128,
        offsetX: [0, 0, 0, 0, 0],
        speed: 150
      },
      "male_werewolf": {
        path: this.maleWerewolfValue,
        frames: 5,
        frameWidth: 128,
        frameHeight: 128,
        offsetX: [0, 0, 0, 0, 0],
        speed: 170
      },
      "female_werewolf": {
        path: this.femaleWerewolfValue,
        frames: 6,
        frameWidth: 128,
        frameHeight: 128,
        offsetX: [0, 0, 0, 0, 0],
        speed: 170
      },
      "female_vampire": {
        path: this.femaleVampireValue,
        frames: 6,
        frameWidth: 128,
        frameHeight: 128,
        offsetX: [0, 0, 0, 0, 0],
        speed: 160
      },
      "male_vampire": {
        path: this.maleVampireValue,
        frames: 5,
        frameWidth: 128,
        frameHeight: 128,
        offsetX: [0, 0, 0, 0, 0],
        speed: 160
      }
    }
  }
}
