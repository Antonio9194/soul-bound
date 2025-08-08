import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dailyQuestsDiv", "mainQuestDiv"]

  fire(event) {
    const selected = event.target.value

    const dailyQuestsDiv = this.dailyQuestsDivTarget
    const mainQuestDiv = this.mainQuestDivTarget

    dailyQuestsDiv.classList.add("d-none")
    mainQuestDiv.classList.add("d-none")

    if (selected === "routine") {
      dailyQuestsDiv.classList.remove("d-none")
    } else if (selected === "long_term_goal") {
      mainQuestDiv.classList.remove("d-none")
    } else if (selected === "both") {
      dailyQuestsDiv.classList.remove("d-none")
      mainQuestDiv.classList.remove("d-none")
    }
  }
}