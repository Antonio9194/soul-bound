class TavernsController < ApplicationController
  def index
    @characters = Character.all
  end
end
