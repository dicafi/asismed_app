class ChangeDoctorIdToUuidInAppointments < ActiveRecord::Migration[8.0]
  def up
    # Paso 1: Agregar una nueva columna doctor_uuid de tipo uuid
    add_column :appointments, :doctor_uuid, :uuid, default: "gen_random_uuid()"

    # Paso 2: Copiar los valores existentes de doctor_id a doctor_uuid (si es necesario)
    execute <<-SQL
      UPDATE appointments
      SET doctor_uuid = gen_random_uuid()
      WHERE doctor_id IS NOT NULL;
    SQL

    # Paso 3: Eliminar la columna antigua doctor_id
    remove_column :appointments, :doctor_id

    # Paso 4: Renombrar la nueva columna doctor_uuid a doctor_id
    rename_column :appointments, :doctor_uuid, :doctor_id

    # Paso 5: Agregar un índice para la nueva columna doctor_id
    add_index :appointments, :doctor_id
  end

  def down
    # Revertir los cambios si es necesario
    add_column :appointments, :doctor_id, :bigint
    execute <<-SQL
      UPDATE appointments
      SET doctor_id = NULL;
    SQL
    remove_column :appointments, :doctor_id
  end
end
