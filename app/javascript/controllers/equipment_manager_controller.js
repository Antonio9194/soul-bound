import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="equipment-manager"
export default class extends Controller {
  static targets = ["inventoryItems", "slot"]

  equip(event) {
    event.preventDefault()
    
    // Get the clicked button's parent div (the inventory item)
    const itemDiv = event.currentTarget.closest("[data-item]")
    if (!itemDiv) return

    // Get the slot type from data attribute
    const slotType = itemDiv.dataset.slot
    const itemImg = itemDiv.querySelector("img")

    // Find the corresponding gear slot
    const gearSlot = this.slotTargets.find(slot => slot.dataset.slot === slotType)
    if (!gearSlot) return

    // Remove any existing item in the slot
    gearSlot.innerHTML = ""

    // Clone the image and append it to the gear slot
    const clonedImg = itemImg.cloneNode(true)
    gearSlot.appendChild(clonedImg)

    // Optional: mark the item as equipped visually in the inventory
    itemDiv.classList.add("equipped")

    // Optionally, make an AJAX request to update equipped: true in Rails
    const itemId = itemDiv.dataset.inventoryItemId
    fetch(`/inventory_items/${itemId}/equip`, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ equipped: true })
    })
  }
}