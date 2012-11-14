class SeleccionesController < ApplicationController

  skip_before_filter :mis_equipos, :only => [:change_seleccion]
  def new
    @seleccion = Seleccion.new(:user_id => current_user.id)
    liga = session[:liga_eq]


    @seleccion.liga = liga if liga.present?
  end

  def create
    session[:liga_eq] = nil
    @seleccion = Seleccion.new params[:seleccion]
    @seleccion.user_id = current_user.id

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


  def change_seleccion
    seleccion = Seleccion.find params["id_seleccion"]
    not_found if current_user != seleccion.user

    current_user.current_seleccion(session, seleccion)
    seleccion.fecha_visto = Time.now
    mis_equipos
    respond_to do |format|
      flash[:notice] = t('seleccion.change_ok', :equipo => seleccion.nombre )
      format.js
    end
  end

  def plantilla
    jugadores = Seleccion.find(params[:id]).jugadores

    @porteros = jugadores.map{|x| x if x.posicion == Jugador::POSICIONES[:portero]}.compact!
    @defensas = jugadores.map{|x| x if x.posicion == Jugador::POSICIONES[:defensa]}.compact!
    @medios = jugadores.map{|x| x if x.posicion == Jugador::POSICIONES[:medio]}.compact!
    @delanteros = jugadores.map{|x| x if x.posicion == Jugador::POSICIONES[:delantero]}.compact!
  end


end
