class CreateDiagnostics < ActiveRecord::Migration[8.0]
  def change
    create_table :diagnostics do |t|
      t.string :key, null: false
      t.string :description, null: false

      t.timestamps
    end

    add_index :diagnostics, :key, unique: true
  end
end
