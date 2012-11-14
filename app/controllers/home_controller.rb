class HomeController < ApplicationController
  def index

  end

  def prueba
    @equipos = Equipo.all

    respond_to do |format|
      format.json {render :json => @equipos}
    end
  end
end
