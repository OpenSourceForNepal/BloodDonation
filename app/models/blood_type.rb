# == Schema Information
#
# Table name: blood_types
#
#  id         :integer          not null, primary key
#  type_enum  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BloodType < ActiveRecord::Base
  extend Enumerize
  belongs_to :donor
  has_and_belongs_to_many :hospitals

  enumerize :type_enum, in: [:o_positive, :o_negative, :a_positive, :a_negative, :b_positive, :b_negative, :ab_positive, :ab_negative]
end
