class CreateBloodTypesHospitals < ActiveRecord::Migration
  def change
    create_table :blood_types_hospitals do |t|
      t.belongs_to :hospital, index: true
      t.belongs_to :blood_type, index: true
      t.datetime :expires_on
      t.timestamps null: false
    end
  end
end
