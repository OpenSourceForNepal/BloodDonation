# puts 'Seeding 10 Fake Donor'
blood_types = %i(o_positive o_negative a_positive a_negative b_positive b_negative ab_positive ab_negative)

10.times do
  Donor.delay.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    cell_phone: [Faker::Number.number(10), '9779842667545', '+9779898989898'].sample,
    email: Faker::Internet.email,
    city: 'Kathmandu',
    state: 'Bagmati',
    blood_type: blood_types.sample
  )
end

blood_types.each do |blood_type|
  BloodType.create(
    blood_type: blood_type
  )
end
