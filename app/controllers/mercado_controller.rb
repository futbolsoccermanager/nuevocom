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

    @mercado = Mercado.where(:jugador_id => @jugadores.map{|x| x.id})
  end

  def create
    jugador = Jugador.find params[:jugador_id]
    @jugadores = current_user.current_seleccion(session).jugadores

    if @jugadores.include? jugador
      m = Mercado.create :fecha_inclusion => Time.now, :jugador_id => jugador.id, :liga_id => current_user.current_seleccion(session).liga.id
      @mercado = Mercado.where(:jugador_id => @jugadores.map{|x| x.id})

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
      @mercado = Mercado.where(:jugador_id => @jugadores.map{|x| x.id})

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
    filtros[:equipo_id] = params['equipo_jugador']

    @jugadores = Jugador.where(filtros.reject{|k,v| v.blank?}).page(pagina)
  end
end
