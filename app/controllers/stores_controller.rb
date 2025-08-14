class StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :purchase]

  def list_items
    @items = Item.all
  end

  def show
    @item
  end

  def purchase
    if current_user.character.coin >= @item.price
      current_user.character.coin -= @item.price
      current_user.character.save
      flash[:notice] = "You've purchased #{@item.name}!"
    else
      flash[:alert] = "You don't have enough coins to buy #{@item.name}."
    end
    redirect_to list_items_store_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
