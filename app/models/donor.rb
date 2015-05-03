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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Donor < ActiveRecord::Base
  geocoded_by :address, :latitude  => :lat, :longitude => :long
  before_validation :normalize_data
  after_validation :geocode
  has_one :blood_type

  validates :first_name, presence: { :message => 'First name cannot be blank!' }
  validates :cell_phone, presence: { :message => 'We need cell phone number so we can notify you!' }
  validates :city, presence: { :message => 'Please tell us which city you live in.' }
  validates :state, presence: { :message => 'We need your Aanchal so we can find the correct location.' }
  validates :cell_phone, inclusion: { :in => 10..14, :message => 'Cell phone number you entered in invalid!' }

  def address
    [street, city, state, country].compact.join(', ')
  end

  def fullname
    [first_name, last_name].compact.join(', ')
  end

  def normalize_data
    self.first_name.try(:capitalize!)
    self.last_name.try(:capitalize!) if self.last_name.present?
    self.cell_phone.gsub!(/\s|\.|\-|\(|\)/, '').insert(0, '+977') if self.cell_phone.present?
    self.email.squish.try(:downcase!) if self.contact_person_email.present?
    self.street.squish.try(:capitalize!) if self.street.present?
    self.city.squish.try(:capitalize!) if self.city.present?
    self.state.squish.try(:capitalize!) if self.state.present?
  end
end
