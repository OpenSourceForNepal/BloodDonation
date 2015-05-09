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
  geocoded_by :city, :latitude  => :lat, :longitude => :long
  before_validation :normalize_data, :nepal_phone
  after_validation :geocode
  has_and_belongs_to_many :blood_types

  validates :name, presence: { :message => 'Name of the Hospital cannot be blank' }
  validates :city, presence: { :message => 'We need city to locate this hospital.' }
  validates :state, presence: { :message => 'We need Aanchal so we can find the correct location.' }
  validates :contact_person_phone, presence: { :message => 'Contact person\'s phone number cannot be blank.' }


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
  end

  def geo_code
    geocode if (self.lat.nil? || self.long.nil?)
  end

  # Taking both landline and cell into consideration
  # TODO: Solve this with regex checks
  def nepal_phone
    phone = self.contact_person_phone.gsub(/\s|\.|\-|\(|\)/, '')
    phone = if (phone.start_with?('+977') && phone.length == 14) || (phone.start_with?('+9771') && phone.length == 11)
                phone
              elsif (phone.start_with?('977') && phone.length == 13) || (phone.start_with?('9771') && phone.length == 10)
                phone.insert(0, '+')
              elsif phone.blank?
                phone
              elsif phone.length == 7
                phone.insert(0, '+9771')
              else
                phone.insert(0, '+977')
              end

    self.contact_person_phone = phone
  end
end
