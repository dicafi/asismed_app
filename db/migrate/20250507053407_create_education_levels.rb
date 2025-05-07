class CreateEducationLevels < ActiveRecord::Migration[8.0]
  def change
    create_table :education_levels do |t|
      t.string :description

      t.timestamps
    end
  end
end
