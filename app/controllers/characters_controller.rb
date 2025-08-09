class CharactersController < ApplicationController
  def index
    @character = Character.find(:user_id)
  end
  def new
    @character = Character.new
  end
  def create
    @character = Character.new(new_character_params)
  end
  def update
    if @character.save
      redirect_to character_path, notice: "Your character was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def new_character_params
    params.require(:character).permit(:name, :class_name, :gender, :apperance)
  end
end
