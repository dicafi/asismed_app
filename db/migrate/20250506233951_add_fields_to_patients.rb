class AddFieldsToPatients < ActiveRecord::Migration[7.0]
  def change
    change_table :patients do |t|
      t.string :last_name, null: false
      t.string :second_last_name, null: false
      t.date :birth_date, null: false
      t.string :phone_number, null: false
      t.string :email, null: false
      t.integer :gender, null: false
      t.integer :marital_status_id
      t.string :occupation
      t.integer :education_level_id
      t.string :postal_code
      t.string :state
      t.string :municipality
      t.string :neighborhood
      t.string :address
      t.string :origin
      t.string :religion
      t.integer :interrogation
      t.integer :insurer_id
    end
  end
end
