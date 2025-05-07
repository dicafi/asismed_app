class AddForeignKeysToPatients < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :patients, :education_levels
    add_foreign_key :patients, :marital_statuses
    add_foreign_key :patients, :insurers
  end
end
