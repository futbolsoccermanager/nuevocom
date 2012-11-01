class LigasController < ApplicationController

  def new

    @liga = Liga.new Liga::DEFAULT_VALUES.merge(:creador => current_user)

  end

  def index
  end

  def show
  end

  def create
    @liga = Liga.new params[:liga]
    @liga.save
    if @liga.errors.present?
      @liga.errors.each do |campo, error|
        flash[:error] << error
      end
    else
      flash[:notice] = t('ligas.nueva_liga.ok_crear')
    end
  end
end
