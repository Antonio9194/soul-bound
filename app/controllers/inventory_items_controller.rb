class InventoryItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_inventory_item, only: [:show, :equip, :unequip]

  def index
    @inventory_items = current_user.character.inventory_items
    @equipped_items = equipped_item.item.img
  end

  def sell 
    @inventory_item = current_user.character.inventory_items.find(params[:id])
    item = @inventory_item.item
    sell_price = item.price / 2
    current_user.character.coin += sell_price
    current_user.character.save
    @inventory_item.destroy

    flash[:notice] = "You sold #{item.name} for #{sell_price} coins!"
   redirect_to character_path
  end

  def show
  end

  def equip
    @inventory_item = InventoryItem.find(params[:id])
    @inventory_item.update(equipped: true)
    redirect_to character_path, notice: "#{@inventory_item.item.name} equipped!"
  end

  def unequip
    @inventory_item = InventoryItem.find(params[:id])
    @inventory_item.update(equipped: false)
    redirect_to character_path, notice: "#{@inventory_item.item.name} unequipped!"
  end


  private

  def set_inventory_item
    @inventory_item = current_user.character.inventory_items.find(params[:id])
  end
end
