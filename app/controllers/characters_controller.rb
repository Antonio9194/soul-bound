class CharactersController < ApplicationController

  def show
    @character = Character.find(params[:id])
  end

  def new
      @character = Character.new
  end

  def create
    @character = Character.new(new_character_params)

    @character.user_id = current_user.id
    @character.level = 1
    @character.xp = 0
    @character.coin = 0

    if @character.save
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
  private

  def new_character_params
    params.require(:character).permit(:name, :class_name, :gender, :apperance)
  end

  def update_character_params
    params.require(:character).permit(:gender, :apperance)
  end
end
