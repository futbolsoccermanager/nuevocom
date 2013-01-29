class SeleccionesController < ApplicationController

  skip_before_filter :mis_equipos, :only => [:change_seleccion]


  def new
    @seleccion = Seleccion.new(:user_id => current_user.id)
    liga = session[:liga_eq]
    if params[:liga_id].present?
      liga = Liga.find params[:liga_id]
    end
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
      current_user.current_seleccion(session,@seleccion)
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
    activar_flag_titulares(titulares)
    titulares_y_suplentes
    flash[:notice] = t('seleccion.once_titular.change_ok')

  end


  def cambiar_tactica
    tactica = params[:tactica].split("_")
    titulares_y_suplentes
    tactica_old = @seleccion.tactica.split("_")
    num_defensas = tactica[0].to_i
    num_medios = tactica[1].to_i
    num_delanteros = tactica[2].to_i

    if @defensas_titulares.present?
      defensas =  reajustar_posiciones(num_defensas,@defensas,tactica_old[0].to_i, @defensas_titulares)
      @defensas = defensas[:banquillo]
      @defensas_titulares = defensas[:titulares]
    end
    if @medios_titulares.present?
      medios =    reajustar_posiciones(num_medios,@medios, tactica_old[1].to_i,@medios_titulares)
      @medios = medios[:banquillo]
      @medios_titulares = medios[:titulares]
    end
    if @delanteros_titulares.present?
      delanteros =  reajustar_posiciones(num_delanteros,@delanteros, tactica_old[2].to_i,@delanteros_titulares)
      @delanteros = delanteros[:banquillo]
      @delanteros_titulares = delanteros[:titulares]
    end

    titulares = (@porteros_titulares + @defensas_titulares + @medios_titulares + @delanteros_titulares).map{|x| x.id.to_s}

    activar_flag_titulares(titulares)



    @seleccion.tactica = params[:tactica]
    @seleccion.save
    flash[:notice] = t('seleccion.once_titular.change_tactica')
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

    def reajustar_posiciones(num_by_new_position,jugadores_banquillo, num_by_old_position, jugadores_titulares)
      titulares = jugadores_titulares[0..num_by_new_position - 1]
      if num_by_old_position > num_by_new_position
        jugadores_banquillo = jugadores_banquillo + (jugadores_titulares - titulares)
      end
      return {:titulares => titulares, :banquillo => jugadores_banquillo}
    end

    def activar_flag_titulares(titulares)
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
    end
end
