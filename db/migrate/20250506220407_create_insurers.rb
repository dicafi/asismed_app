class CreateInsurers < ActiveRecord::Migration[8.0]
  def change
    create_table :insurers do |t|
      t.string :description

      t.timestamps
    end
  end
end
