module  Admin
  class PuntuacionesController < BaseController

    def index
      @equipos = Equipo.all
    end


  end
end
