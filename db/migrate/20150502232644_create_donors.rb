class CreateDonors < ActiveRecord::Migration
  def change
    create_table :donors do |t|
      t.string :first_name
      t.string :last_name
      t.string :cell_phone
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country, default: 'Nepal'
      t.float  :lat
      t.float  :long
      t.integer :commute_radius, default: 5

      t.timestamps null: false
    end
  end
end
