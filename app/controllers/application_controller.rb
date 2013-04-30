class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :mis_equipos
  before_filter :get_tweets


  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end


  def mis_equipos
    @mis_equipos = current_user.mis_selecciones if current_user
  end

  def get_tweets
    @tweet_feeds = Twitter.user_timeline("LigaBBVA") rescue []

    # TODO de momento deshabilitamos mensajes
    if user_signed_in? && false
      # ligas propias
      ligas = current_user.selecciones.map{|x| x.liga_id}
      @msgs = Message.where("liga_id IN (?)", ligas)
    end

  end

end
