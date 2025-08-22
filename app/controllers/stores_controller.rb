class StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :purchase]

  def list_items
    @items = Item.all
    @rotating_items = @items.sample(8)
  end

  def show
    @item
  end

  def purchase
    if current_user.character.inventory_items.exists?(item_id: @item.id)
      flash[:alert] = "You already own this item!"
    else
      if current_user.character.coin >= @item.price
        current_user.character.coin -= @item.price
        current_user.character.save
        # Add purchased item to inventory
        current_user.character.inventory_items.create!(item: @item, equipped: false)

        flash[:notice] = "You've purchased #{@item.name}!"
      else
        flash[:alert] = "You don't have enough coins to buy #{@item.name}."
      end
    end
    redirect_to list_items_stores_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
