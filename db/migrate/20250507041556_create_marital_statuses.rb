class CreateMaritalStatuses < ActiveRecord::Migration[8.0]
  def change
    create_table :marital_statuses do |t|
      t.string :description

      t.timestamps
    end
  end
end
