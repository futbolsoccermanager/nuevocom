class Api::TokenController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    identificador = params[:login] || params[:email]
    password = params[:password]

    if request.format != :json
      render :status=>406, :json=>{:message=>I18n.t('errors.invalid_nojson')}
      return
    end

    if identificador.blank? or password.blank?
      render :status=>400, :json=>{:message=>I18n.t('errors.invalid_nouserpwd')}
      return
    end

    @user=User.find_by_email(identificador.downcase) || User.find_by_username(identificador.downcase)

    if @user.blank?
      render :status=>401, :json=>{:message=>I18n.t('errors.invalid_user')}
      return
    end

    @user.ensure_authentication_token
    @user.save!

    if @user.valid_password?(password)
      render :status=>200, :json=>{:token=>@user.authentication_token}
    else
      render :status=>401, :json=>{:message=>I18n.t('errors.invalid_user')}
    end

  end

  def destroy
    @user=User.find_by_authentication_token(params[:id])
    if @user.blank?
      render :status=>404, :json=>{:message=>I18n.t('errors.invalid_token')}
    else
      @user.reset_authentication_token!
      render :status=>200, :json=>{:token=>params[:id]}
    end
  end
end
