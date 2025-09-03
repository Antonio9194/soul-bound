class TavernsController < ApplicationController
  skip_after_action :verify_policy_scoped, only: :index
  def index
    @characters = Character.all

  end
end
