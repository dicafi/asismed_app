class CreateMedicalNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :medical_notes do |t|
      t.text :ta

      t.timestamps
    end
  end
end
