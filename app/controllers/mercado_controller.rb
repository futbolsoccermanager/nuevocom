class MercadoController < ApplicationController
  def index
    seleccion = Seleccion.find(params[:id_seleccion])

    not_found if current_user != seleccion.user

    liga_id = seleccion.liga_id
    @jugadores_mercado = Mercado.where(:liga_id => liga_id)

    @ofertas = seleccion.ofertas

    #todo mientras no se actualicen precios se mete a pelo
    @jugadores_mercado.each do |jm|
      j = jm.jugador
      if j.precio.blank?
        j.precio = rand * 50000000
        j.save
      end
    end
  end

  def create_ofertas

    params.select{|par, val| par.starts_with?('oferta') && val.present?}.each do |puja|
      oferta = Oferta.new :mercado_id => puja.first.delete('oferta_'), :seleccion_id => current_user.current_seleccion(session).id, :valor => puja.last.to_f, :estado => Oferta::PENDIENTE

      oferta.save_if_valid

    end

    respond_to do |format|
      format.js
    end

  end

  def new
    @jugadores = current_user.current_seleccion(session).jugadores

    @mercado = Mercado.where(:liga_id => current_user.current_seleccion(session).liga_id, :jugador_id => @jugadores.map{|x| x.id})

    p @mercado
  end

  def create
    jugador = Jugador.find params[:jugador_id]
    @jugadores = current_user.current_seleccion(session).jugadores

    if @jugadores.include? jugador
      Mercado.create :fecha_inclusion => Time.now, :jugador_id => jugador.id, :liga_id => current_user.current_seleccion(session).liga.id
      @mercado = Mercado.where(:liga_id => current_user.current_seleccion(session).liga_id, :jugador_id => @jugadores.map{|x| x.id})

      flash[:notice] = I18n.t 'mercado.nuevo.realizado'
    else
      flash[:error] = I18n.t 'errors.mercado.invalido'
    end

    render 'operacion'
  end

  def destroy
    jugador = Jugador.find params[:id]
    @jugadores = current_user.current_seleccion(session).jugadores

    if @jugadores.include? jugador
      jmercado = Mercado.where(:jugador_id => jugador.id, :liga_id => current_user.current_seleccion(session).liga.id).first
      jmercado.destroy
      @mercado = Mercado.where(:liga_id => current_user.current_seleccion(session).liga_id, :jugador_id => @jugadores.map{|x| x.id})

      flash[:notice] = I18n.t 'mercado.nuevo.realizado'
    else
      flash[:error] = I18n.t 'errors.mercado.invalido'
    end
    render 'operacion'
  end

  def buscarjugador
    @equipos = Equipo.all
    pagina = params[:page] || 1

    filtros = {}
    if params['jugador']
      filtros[:equipo_id] = params['jugador']['equipo']
      filtros[:posicion] = params['jugador']['posicion']
    end

    if params['puntos_minimo'].present? || params['puntos_maximo'].present?
      arr_ids = []
      pminimo = (params['puntos_minimo'].presence || Settings.mercado.puntos.minimo).to_i
      pmaximo = (params['puntos_maximo'].presence || Settings.mercado.puntos.maximo).to_i

      Jugador.select(:id).each do |j|
        arr_ids << j.id if (pminimo..pmaximo).member? PuntosJugador.total_puntuacion(j.id)
      end
      filtros[:id] = arr_ids
    end

    filtros[:precio] = (params['valor_minimo'].presence || Settings.mercado.valor.minimo).to_f..(params['valor_maximo'].presence || Settings.mercado.valor.maximo).to_f

    if params["busca_nombre"].present?
      @jugadores = Jugador.scoped(:conditions => filtros.reject{|k,v| v.blank?}).where("nombre like ?", "%#{params['busca_nombre']}%").page(pagina)
    else
      @jugadores = Jugador.where(filtros.reject{|k,v| v.blank?}).page(pagina)
    end

    respond_to do |format|
      format.js
      format.html
    end

  end
end
