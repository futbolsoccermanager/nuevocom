class LigasController < ApplicationController

  def new

    @liga = Liga.new Liga::DEFAULT_VALUES.merge(:creador => current_user)

  end

  def index
  end

  def show
  end

  def create
  end
end
