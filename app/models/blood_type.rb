# == Schema Information
#
# Table name: blood_types
#
#  id         :integer          not null, primary key
#  blood_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BloodType < ActiveRecord::Base
  extend Enumerize
  has_and_belongs_to_many :hospitals

  enumerize :blood_type, in: [:o_positive, :o_negative, :a_positive, :a_negative, :b_positive, :b_negative, :ab_positive, :ab_negative]
  validates :blood_type, uniqueness: true
end
