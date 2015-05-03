# == Schema Information
#
# Table name: hospitals
#
#  id                   :integer          not null, primary key
#  name                 :string
#  street               :string
#  city                 :string
#  state                :string
#  postal_code          :string
#  country              :string           default("Nepal")
#  lat                  :string
#  long                 :string
#  contact_person_name  :string
#  contact_person_email :string
#  contact_person_phone :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Hospital < ActiveRecord::Base
  geocoded_by :address, :latitude  => :lat, :longitude => :long
  before_validation :normalize_data
  after_validation :geocode
  has_and_belongs_to_many :blood_types

  validates :name, presence: { :message => 'Name of the Hospital cannot be blank!' }
  validates :city, presence: { :message => 'We need city to locate this hospital.' }
  validates :state, presence: { :message => 'We need Aanchal so we can find the correct location.' }
  validates :foo, length: {is: 10, message: 'Phone number you entered in invalid!'}, allow_blank: false


  def address
    [street, city, state, country].compact.join(', ')
  end

  def normalize_data
    self.name.try(:capitalize!)
    self.street.squish.try(:capitalize!) if self.street.present?
    self.city.squish.try(:capitalize!)
    self.state.squish.try(:capitalize!)
    self.contact_person_name.squish.try(:capitalize!) if self.contact_person_name.present?
    self.contact_person_email.squish.try(:downcase!) if self.contact_person_email.present?
    self.cell_phone.gsub!(/\s|\.|\-|\(|\)/, '').insert(0, '+977') if self.cell_phone.present?
  end
end
