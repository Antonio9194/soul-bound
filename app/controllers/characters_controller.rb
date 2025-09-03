class CharactersController < ApplicationController

  def show
    @character = Character.find(params[:id])
    @inventory_items = @character.items
    @equipped_items = @character.inventory_items.where(equipped: true).map(&:item)
  end

  def new
      @character = Character.new
  end

  def create
    @character = Character.new(new_character_params)

    @character.user_id = current_user.id
    @character.level = 1
    @character.xp = 0
    @character.coin = 12000
    @character.slots = 10
    if @character.save
      @items = Item.where(rarity: "Common", item_type: ["Book","Sword", "Staff"])
      @random = rand(@items.length)
      current_user.character.inventory_items.create!(item: @items[@random], equipped: false)
      redirect_to dashboard_quests_path, notice: "Your character was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    @character = Character.find(params[:id])
    if @character.update(update_character_params)
      redirect_to character_path(@character), notice: "Your character was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to new_character_path
  end

  def purchase_slot
    @character = Character.find(params[:id])
    if @character.purchase_slot
      redirect_to character_path(@character), notice: "You have purchased a slot!"
    else
      redirect_to character_path(@character), alert: "You don't have enough coins!"
    end
  end

  def sell_slot
    @character = Character.find(params[:id])
    if @character.sell_slot
      redirect_to character_path(@character), notice: "You have sold a slot!"
    else
      if @character.slots <= 1
        redirect_to character_path(@character), notice: "You can't have less than 1 slot!"
      elsif @character.inventory_items.count >= @character.slots
        redirect_to character_path(@character), notice: "You can't have less slots than your inventory items!"
      end
    end
  end

  private

  def new_character_params
    params.require(:character).permit(:name, :class_name, :gender)
  end

  def update_character_params
    params.require(:character).permit(:name, :class_name, :gender)
  end
end
