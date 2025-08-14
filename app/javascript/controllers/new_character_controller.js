import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-character"
export default class extends Controller {
  static targets = ["appearance", "gender", "class"]

}
