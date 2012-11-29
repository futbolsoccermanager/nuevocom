# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string(255)
#  admin                  :boolean
#  premium                :boolean
#  provider               :string(255)
#  uid                    :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :lockable, :confirmable

  attr_accessor :login

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :admin, :premium, :email, :password, :password_confirmation, :remember_me,:provider, :uid
  # attr_accessible :title, :body

  has_many :selecciones
  has_many :messages

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {:value => login.downcase}]).first
    else
      where(conditions).first
    end
  end

  def sin_selecciones?
    selecciones.empty?
  end

  def mis_selecciones
    selecciones.order('fecha_visto desc')
  end

  def current_seleccion(session, nueva=nil)
    nueva = mis_selecciones.first if session[:current_seleccion].blank? && nueva.blank?
    nueva.present? ? session[:current_seleccion] = nueva : session[:current_seleccion]
  end
end
