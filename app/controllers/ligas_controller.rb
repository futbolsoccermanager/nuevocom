class LigasController < ApplicationController
  require "jobs/RellenaMercadoJob"

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
        @ligas = Liga.with_name_equal params[:busca_liga], Liga::PRIVACIDAD[tipo.to_sym]
    end
    respond_to do |format|
      format.js
    end
  end


end
