# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  texto      :text
#  fecha      :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  liga_id    :integer
#

class Message < ActiveRecord::Base
  attr_accessible :fecha, :texto, :user_id, :liga_id

  belongs_to :user
  belongs_to :liga

  #acts_as_mentioner
end
