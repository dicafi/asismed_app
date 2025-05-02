class AddOfficeToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :office, :string
  end
end
