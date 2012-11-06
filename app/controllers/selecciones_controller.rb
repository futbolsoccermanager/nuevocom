class SeleccionesController < ApplicationController

  def new
    @seleccion = Seleccion.new(:user_id => current_user.id)
    liga = session[:liga_eq]


    @seleccion.liga = liga if liga.present?
  end

  def create
    session[:liga_eq] = nil
    @seleccion = Seleccion.new params[:seleccion]

    @seleccion.save
    if @seleccion.errors.present?
      errores = []
      @seleccion.errors.each do |err|
        errores << err
      end
      flash[:error] = errores.join "\n"
      render 'new'
    else
      redirect_to mercado_path(@seleccion.id)
    end
  end
end
