class AddDefaultTrueToFieldActiveFromUser < ActiveRecord::Migration[8.0]
  def change
    change_column_default :users, :active, from: nil, to: true
  end
end
