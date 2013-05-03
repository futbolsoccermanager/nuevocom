class MercadoController < ApplicationController
  before_filter :datos_ofertas, :only => [:index, :create_ofertas]

  def index

    #todo mientras no se actualicen precios se mete a pelo
    @jugadores_mercado.each do |jm|
      j = jm.jugador
      if j.precio.blank?
        j.precio = rand * 50000000
        j.save
      end
    end
  end

  # crea una oferta de un jugador del mercado
  # si ya existe, se modifica la existente en save_if_valid
  # si aparece el flag delflag activado, se elimina
  # devuelve un mensaje con los cambios realizados
  def create_ofertas



    arr_ofertas = []
    params.select { |par, val| par.starts_with?('oferta') && val.present? }.each do |puja|
      mid = puja.first.delete('oferta_')
      eliminar = params["delflag#{mid}"] == '1'
      oferta = Oferta.new :mercado_id => mid, :seleccion_id => current_user.current_seleccion(session).id, :valor => puja.last.to_f, :estado => Oferta::PENDIENTE
      oferta.estado = Oferta::CANCELADA if eliminar

      oferta = oferta.save_if_valid
      arr_ofertas << I18n.t('mercado.oferta.oferta_creada', {:jugador => oferta.mercado.jugador.nombre, :valor => oferta.valor})
    end

    flash.notice = arr_ofertas.join '<br/>'

    # actualizamos los datos
    datos_ofertas

    respond_to do |format|
      format.js
    end

  end

  def new
    @jugadores = current_user.current_seleccion(session).jugadores
    @mercado = Mercado.where(:liga_id => current_user.current_seleccion(session).liga_id, :jugador_id => @jugadores.map { |x| x.id })
  end

  def create
    jugador = Jugador.find params[:jugador_id]
    @jugadores = current_user.current_seleccion(session).jugadores

    if @jugadores.include? jugador
      Mercado.create :fecha_inclusion => Time.now, :jugador_id => jugador.id, :liga_id => current_user.current_seleccion(session).liga.id
      @mercado = Mercado.where(:liga_id => current_user.current_seleccion(session).liga_id, :jugador_id => @jugadores.map { |x| x.id })

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
      @mercado = Mercado.where(:liga_id => current_user.current_seleccion(session).liga_id, :jugador_id => @jugadores.map { |x| x.id })

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
      @jugadores = Jugador.scoped(:conditions => filtros.reject { |k, v| v.blank? }).where("nombre like ?", "%#{params['busca_nombre']}%").page(pagina)
    else
      @jugadores = Jugador.where(filtros.reject { |k, v| v.blank? }).page(pagina)
    end

    respond_to do |format|
      format.js
      format.html
    end

  end

  def peticion_jugador
    @jugador = Jugador.find(params[:jugador])
    seleccion = @jugador.plantilla_selecciones.select { |x| x.seleccion.liga_id == current_user.current_seleccion(session).liga_id }.first.try(:seleccion)
    if seleccion.blank? # || seleccion.user.id == current_user.id
      @error = I18n.t('mercado.negociar.no_negociable')
    else
      @usuario = seleccion.user
    end
  end

  private
  def datos_ofertas
    seleccion = Seleccion.find(params[:id_seleccion] || current_user.current_seleccion(session))

    not_found if current_user != seleccion.user

    liga_id = seleccion.liga_id
    @jugadores_mercado = Mercado.where(:liga_id => liga_id)

    @ofertas = seleccion.ofertas.activas

  end
end
