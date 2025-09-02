class ItemsController < ApplicationController
  def index
    @items = Item.all

    authorize @items

  end

  def show
    @item = Item.find(params[:id])

    authorize @items

  end
end
