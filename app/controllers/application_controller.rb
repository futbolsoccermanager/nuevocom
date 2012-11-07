class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :mis_equipos

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end


  def mis_equipos
    @mis_equipos = current_user.selecciones if current_user
  end
end
