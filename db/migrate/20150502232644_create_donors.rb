class CreateDonors < ActiveRecord::Migration
  def change
    create_table :donors do |t|
      t.string :full_name
      t.string :cell_phone
      t.string :email
      t.string :address
      t.float  :lat
      t.float  :long
      t.integer :commute_radius, default: 5
      t.string :blood_type

      t.timestamps null: false
    end
  end
end
