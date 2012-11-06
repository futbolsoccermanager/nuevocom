class LigasController < ApplicationController
  require "jobs/RellenaMercadoJob"
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
      errores = []
      @liga.errors.each do |campo, error|
        errores << error
      end
      flash[:error] = errores.join "\n"
      render 'new'
    else
      flash[:notice] = t('ligas.nueva_liga.ok_crear')
      session[:liga_eq] = @liga

      RellenaMercadoJob.relleno @liga.id

      redirect_to new_selecciones_path
    end
  end
end
