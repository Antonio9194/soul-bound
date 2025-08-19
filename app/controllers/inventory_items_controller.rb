class InventoryItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_inventory_item, only: [:show, :equip, :unequip]

  def index
    @inventory_items = current_user.character.inventory_items
  end

  def show
  end

  def equip
    @inventory_item.update(equipped: true)
    redirect_to inventory_items_path, notice: "#{@inventory_item.item.name} equipped!"
  end

  def unequip
    @inventory_item.update(equipped: false)
    redirect_to inventory_items_path, notice: "#{@inventory_item.item.name} unequipped!"
  end

  private

  def set_inventory_item
    @inventory_item = current_user.character.inventory_item.find(params[:id])
  end
end
