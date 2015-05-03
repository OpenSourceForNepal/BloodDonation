# puts 'Seeding 10 Fake Donor'
# 10.times do
#   Donor.delay.create(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     cell_phone: Faker::Number.number(10),
#     email: Faker::Internet.email,
#     city: 'Kathmandu',
#     state: 'Bagmati',
#   )
# end

blood_types = %i(o_positive o_negative a_positive a_negative b_positive b_negative ab_positive ab_negative)

blood_types.each do |blood_type|
  BloodType.create(
    type_enum: blood_type
  )
end