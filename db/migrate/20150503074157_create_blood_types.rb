class CreateBloodTypes < ActiveRecord::Migration
  def change
    create_table :blood_types do |t|
      t.string :blood_type

      t.timestamps null: false
    end
  end
end
