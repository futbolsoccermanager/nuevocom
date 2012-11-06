# app/controllers/errors_controller.rb
class ErrorsController < ApplicationController

  # ERRORS
  # internal_server_error: Información sobre el 500
  # not_found:  Información sobre el 404
  # unprocessable_entity:Información sobre el  422
  # system_error : para capturar errores del sgc, sistema integracion, timeout, socket error ...
  # cancan_access_denied: permisos del cancan

  ERRORS = {
    :internal_server_error  => {:view => 'internal_server_error'},
    :not_found              => {:view => 'not_found'},
    :unprocessable_entity   => {:view => 'unprocessable_entity'},
    :system_error           => {:view => 'system_error',      :layout => 'system_error'},
    :cancan_access_denied   => {:view => 'cancan_access_denied'},
  }.freeze



  ERRORS.dup.each do |e, value|
    define_method e do
      @analytics_prefix = :Sistema
      @pagetitle = e
      @exception = request.env['topgol_added_exception']
      respond_to do |format|
        format.html { render value.delete(:view), value.merge(:status => e) }
        format.any { head e }
      end
    end
  end

end

