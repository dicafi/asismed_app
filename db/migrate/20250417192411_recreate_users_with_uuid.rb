class RecreateUsersWithUuid < ActiveRecord::Migration[8.0]
  def change
    drop_table :users

    create_table :users, id: :uuid do |t|
      t.string :username
      t.string :password_digest
      t.string :profile
      t.string :last_name
      t.string :second_last_name
      t.string :first_name
      t.string :signature
      t.boolean :active
      t.string :phone_number
      t.timestamps
    end
  end
end
