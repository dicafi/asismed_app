class AddFieldsToMedicalNotes < ActiveRecord::Migration[8.0]
  def change
    add_column :medical_notes, :spo2, :string
    add_column :medical_notes, :temperature, :decimal
    add_column :medical_notes, :glucose, :decimal
    add_column :medical_notes, :fr, :decimal
    add_column :medical_notes, :fc, :decimal
    add_column :medical_notes, :weight, :decimal
    add_column :medical_notes, :height, :decimal
    add_column :medical_notes, :current_condition, :text
    add_column :medical_notes, :physical_examination, :text
    add_column :medical_notes, :treatment_plan, :text
    add_column :medical_notes, :prognosis, :text
    add_reference :medical_notes, :appointment, null: false, foreign_key: true
  end
end
