class AddStatusToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :status, :integer, default: 0, null: false
  end
end
