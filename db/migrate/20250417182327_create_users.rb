class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :profile
      t.string :last_name
      t.string :second_last_name
      t.string :first_name
      t.string :signature
      t.boolean :active

      t.timestamps
    end
  end
end
