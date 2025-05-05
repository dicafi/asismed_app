class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.date :date
      t.time :time
      t.references :patient, null: true
      t.references :doctor, null: true
      t.text :details
      t.references :medical_note, null: true

      t.timestamps
    end
  end
end
