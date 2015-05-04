# == Schema Information
#
# Table name: donors
#
#  id             :integer          not null, primary key
#  first_name     :string
#  last_name      :string
#  cell_phone     :string
#  email          :string
#  street         :string
#  city           :string
#  state          :string
#  postal_code    :string
#  country        :string           default("Nepal")
#  lat            :float
#  long           :float
#  commute_radius :integer          default(5)
#  blood_type     :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Donor < ActiveRecord::Base
  extend Enumerize
  geocoded_by :address, :latitude  => :lat, :longitude => :long
  before_validation :normalize_data, :cleanup_cellphone
  after_validation :geocode

  validates :first_name, presence: { :message => 'First name cannot be blank!' }
  validates :cell_phone, presence: { :message => 'We need cell phone number so we can notify you!' }
  validates :city, presence: { :message => 'Please tell us which city you live in.' }
  validates :state, presence: { :message => 'We need your Aanchal so we can find the correct location.' }
  validates :blood_type, presence: { :message => 'What is your blood type ?' }

  enumerize :blood_type, in: [:o_positive, :o_negative, :a_positive, :a_negative, :b_positive, :b_negative, :ab_positive, :ab_negative]

  def address
    [street, city, state, country].compact.join(', ')
  end

  def fullname
    [first_name, last_name].compact.join(', ')
  end

  def normalize_data
    self.first_name.try(:capitalize)
    self.last_name.try(:capitalize) if self.last_name.present?
    self.street.squish.try(:capitalize) if self.street.present?
    self.city.squish.try(:capitalize) if self.city.present?
    self.state.squish.try(:capitalize) if self.state.present?
  end

  def cleanup_cellphone
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
