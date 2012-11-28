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
    seleccion.save
    mis_equipos
    respond_to do |format|
      flash[:notice] = t('seleccion.change_ok', :equipo => seleccion.nombre )
      format.js
    end
  end

  def plantilla
    titulares_y_suplentes
  end

  def save_once_titular
    titulares = params[:id_titulares].split(",")
    p titulares.inspect
    plantilla = PlantillaSeleccion.where(["seleccion_id = ?", params[:id_seleccion]])
    plantilla.each do |jugador|
      if titulares.include?(jugador.jugador_id.to_s)
        jugador.titular = 1
      else
        jugador.titular = 0
      end
      jugador.save
    end
    titulares_y_suplentes
    flash[:notice] = t('seleccion.once_titular.change_ok')

  end


  private

    def titulares_y_suplentes
      banquillo = Jugador.banquillo(params[:id_seleccion])
      once_titular = Jugador.once_titular(params[:id_seleccion])
      @seleccion = Seleccion.find params[:id_seleccion]

      @porteros = banquillo.map{|x| x if x.posicion == Jugador::POSICIONES[:portero]}.compact
      @defensas = banquillo.map{|x| x if x.posicion == Jugador::POSICIONES[:defensa]}.compact
      @medios = banquillo.map{|x| x if x.posicion == Jugador::POSICIONES[:medio]}.compact
      @delanteros = banquillo.map{|x| x if x.posicion == Jugador::POSICIONES[:delantero]}.compact
      @porteros_titulares = once_titular.map{|x| x if x.posicion == Jugador::POSICIONES[:portero]}.compact
      @defensas_titulares = once_titular.map{|x| x if x.posicion == Jugador::POSICIONES[:defensa]}.compact
      @medios_titulares = once_titular.map{|x| x if x.posicion == Jugador::POSICIONES[:medio]}.compact
      @delanteros_titulares = once_titular.map{|x| x if x.posicion == Jugador::POSICIONES[:delantero]}.compact

    end


end
