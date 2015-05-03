class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country, default: 'Nepal'
      t.string :lat
      t.string :long
      t.string :contact_person_name
      t.string :contact_person_email
      t.string :contact_person_phone

      t.timestamps null: false
    end
  end
end
