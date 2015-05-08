# == Schema Information
#
# Table name: donors
#
#  id             :integer          not null, primary key
#  full_name      :string
#  cell_phone     :string
#  email          :string
#  address        :string
#  lat            :float
#  long           :float
#  commute_radius :integer          default(5)
#  blood_type     :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Donor < ActiveRecord::Base
  extend Enumerize
  geocoded_by :address, latitude: :lat, longitude: :long
  before_validation :normalize_data, :nepal_cellphone
  after_validation :geo_code

  validates :full_name, presence: { :message => 'Your name cannot be blank!' }
  validates :cell_phone, presence: { :message => 'Cell phone (mobile) number required for notifications.' }
  validates :address, presence: { :message => 'We need your Address.' }
  validates :blood_type, presence: { :message => 'Blood type.' }

  enumerize :blood_type, in: [:o_positive, :o_negative, :a_positive, :a_negative, :b_positive, :b_negative, :ab_positive, :ab_negative]

  def normalize_data
    self.full_name.try(:capitalize!)
    self.address.squish.try(:capitalize!) if self.address.present?
  end

  def geo_code
    geocode if (self.lat.nil? || self.long.nil?)
  end

  def nepal_cellphone
    cellphone = self.cell_phone.gsub(/\s|\.|\-|\(|\)/, '')
    cellphone = if cellphone.start_with?('+977') && cellphone.length == 14
      cellphone
    elsif cellphone.start_with?('977') && cellphone.length == 13
      cellphone.insert(0, '+')
    elsif cellphone.blank?
      cellphone
    else
      cellphone.insert(0, '+977')
    end

    self.cell_phone = cellphone
  end
end
