class MessagesController < ApplicationController
  def index
  end

  def create
    ligaid = current_user.current_seleccion(session).try(:liga_id)
    @message = Message.create!(params[:message].merge({:fecha => Time.now, :user_id => current_user.id, :liga_id => ligaid}))

    respond_to do |format|
      format.js
    end

  end
end
