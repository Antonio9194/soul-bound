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
    @character.xp = 0
    @character.coin = 0
    if @character.save
      redirect_to character_path(@character), notice: "Your character was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end
  def update

  end

  private

  def new_character_params
    params.require(:character).permit(:name, :class_name, :gender, :apperance)
  end
end
