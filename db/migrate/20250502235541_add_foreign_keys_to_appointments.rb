class AddForeignKeysToAppointments < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :appointments, :patients
    add_foreign_key :appointments, :users, column: :doctor_id
    add_foreign_key :appointments, :medical_notes
  end
end
