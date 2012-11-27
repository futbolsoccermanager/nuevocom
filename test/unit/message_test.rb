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

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
