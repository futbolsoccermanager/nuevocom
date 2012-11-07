class HomeController < ApplicationController
  def index
    @tweet_feeds = Twitter.user_timeline("LigaBBVA")
  end

  def prueba
    @equipos = Equipo.all

    respond_to do |format|
      format.json {render :json => @equipos}
    end
  end
end
