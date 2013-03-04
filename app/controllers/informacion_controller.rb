class InformacionController < ApplicationController

  def index
  end

  def show
    @pag = params[:id]
  end
end
