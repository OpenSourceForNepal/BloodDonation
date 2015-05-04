blood_types = %i(o_positive o_negative a_positive a_negative b_positive b_negative ab_positive ab_negative)
blood_types.each do |blood_type|
  BloodType.create(
    blood_type: blood_type
  )
end
