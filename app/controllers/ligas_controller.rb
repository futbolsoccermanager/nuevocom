class LigasController < ApplicationController
  require "jobs/RellenaMercadoJob"

  before_filter :tipo_busqueda, :only => :list_leagues


  def join_liga
    if params[:tipo] == 'nueva'
      redirect_to new_ligas_path
    end
  end

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


  def search_league
    results = Liga.with_name_like params[:term], params[:tipo]
    array_leagues = results.map {|l| {label: l.nombre, value: l.id, code: l.id}}
    results = array_leagues.to_json
    respond_to do |format|
      format.json {
        render :json => results
      }
    end
  end

  def list_leagues
    tipo = params[:tipo]
    case tipo
      when 'abierta'
        @ligas = Liga.with_name_equal params[:busca_liga], Liga::PRIVACIDAD[tipo.to_sym] if @tipo_busqueda.present?
        @ligas = Liga.with_name_or_creator_like params[:busca_liga], Liga::PRIVACIDAD[tipo.to_sym] unless @tipo_busqueda.present?
      when 'privada'
        @ligas = Liga.with_password_equal params[:liga_privada], Liga::PRIVACIDAD[tipo.to_sym]
    end
    unless @ligas.present?
        render :js => "window.location = '#{new_ligas_url}'"
    else
      respond_to do |format|
        format.js
      end
    end
  end




  private

  def tipo_busqueda
     @tipo_busqueda = params[:tipo_busqueda]
  end

end
