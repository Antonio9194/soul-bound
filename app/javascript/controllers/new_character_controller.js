import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gender", "klass", "display"]
  static values = {
    gender: String,
    klass: String
  }

  connect() {
    // For show page, immediately render
    console.log("hello");
    
    if (!this.genderTargets.length && this.genderValue && this.klassValue) {
      this.render(this.genderValue, this.klassValue)
    }
  }

  render(selectedGender, selectedKlass) {
    const gender = selectedGender || this.genderTargets.find(r => r.checked)?.value
    const klass = selectedKlass || this.klassTargets.find(r => r.checked)?.value

    if (!gender || !klass) {
      this.displayTarget.innerHTML = ""
      if (this.animationInterval) clearInterval(this.animationInterval)
      return
    }

    // Map gender + class to the correct sprite sheet
    let spritePath = ""
    if (gender === "Male" && klass === "Warrior") spritePath = "/assets/male_warrior.png"
    else if (gender === "Female" && klass === "Warrior") spritePath = "/assets/female_warrior.png"
    else if (gender === "Male" && klass === "Mage") spritePath = "/assets/male_mage.png"
    else if (gender === "Female" && klass === "Mage") spritePath = "/assets/female_mage.png"
    else if (gender === "Male" && klass === "Archer") spritePath = "/assets/male_archer.png"
    else if (gender === "Female" && klass === "Archer") spritePath = "/assets/female_archer.png"

    console.log(spritePath);
    

    // Create canvas
    this.displayTarget.innerHTML = '<canvas width="160" height="128"></canvas>'
    const canvas = this.displayTarget.querySelector("canvas")
    const ctx = canvas.getContext("2d")

    const sprite = new Image()
    sprite.src = spritePath

    const totalFrames = 8
    const frameWidth = 60  // each frame width (480 ÷ 8)
    const frameHeight = 64 // original sprite height
    let currentFrame = 0

    sprite.onload = () => {
      if (this.animationInterval) clearInterval(this.animationInterval)

      this.animationInterval = setInterval(() => {
        ctx.clearRect(0, 0, canvas.width, canvas.height)
        ctx.drawImage(
          sprite,
          currentFrame * frameWidth, 0, frameWidth, frameHeight, // source rect
          0, 0, canvas.width, canvas.height                     // destination rect
        )
        currentFrame = (currentFrame + 1) % totalFrames
      }, 200)
    }
  }
}