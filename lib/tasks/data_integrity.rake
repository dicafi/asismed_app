# filepath: /Users/julioacevedo/Documents/Trabajo/Casuy/asismed_app/lib/tasks/data_integrity.rake
namespace :data_integrity do
  desc 'Run all data integrity checks'
  task check_all: :environment do
    Rake::Task['data_integrity:check_users'].invoke
    Rake::Task['data_integrity:check_appointments'].invoke
    Rake::Task['data_integrity:check_diagnostics'].invoke
    Rake::Task['data_integrity:check_education_levels'].invoke
    Rake::Task['data_integrity:check_insurers'].invoke
    Rake::Task['data_integrity:check_marital_statuses'].invoke
    Rake::Task['data_integrity:check_medical_notes'].invoke
    Rake::Task['data_integrity:check_patients'].invoke
  end

  desc 'Check data integrity for User records'
  task check_users: :environment do
    invalid_users = User.find_each.select { |user| !user.valid? }

    if invalid_users.any?
      puts "Found #{invalid_users.count} invalid users:"
      invalid_users.each do |user|
        puts "User ID #{user.id} is invalid: #{user.errors.full_messages.join(', ')}"
      end
      exit 1 # Indica que hubo un error
    else
      puts 'All Users are valid!'
    end
  end

  desc 'Check data integrity for Appointment records'
  task check_appointments: :environment do
    invalid_appointments = Appointment.find_each.select { |appointment| !appointment.valid? }

    if invalid_appointments.any?
      puts "Found #{invalid_appointments.count} invalid appointments:"
      invalid_appointments.each do |appointment|
        puts "appointments ID #{appointment.id} is invalid: ' +
          '#{appointment.errors.full_messages.join(', ')}"
      end
      exit 1 # Indica que hubo un error
    else
      puts 'All Appointments are valid!'
    end
  end

  desc 'Check data integrity for Diagnostic records'
  task check_diagnostics: :environment do
    invalid_diagnostics = Diagnostic.find_each.select { |diagnostic| !diagnostic.valid? }

    if invalid_diagnostics.any?
      puts "Found #{invalid_diagnostics.count} invalid diagnostics:"
      invalid_diagnostics.each do |diagnostic|
        puts "diagnostics ID #{diagnostic.id} is invalid: ' +
          '#{diagnostic.errors.full_messages.join(', ')}"
      end
      exit 1 # Indica que hubo un error
    else
      puts 'All Diagnostics are valid!'
    end
  end

  desc 'Check data integrity for EducationLevel records'
  task check_education_levels: :environment do
    invalid_education_levels = EducationLevel.find_each.select do |education_level|
      !education_level.valid?
    end

    if invalid_education_levels.any?
      puts "Found #{invalid_education_levels.count} invalid education_levels:"
      invalid_education_levels.each do |education_level|
        puts "education_levels ID #{education_level.id} is invalid: ' +
          '#{education_level.errors.full_messages.join(', ')}"
      end
      exit 1 # Indica que hubo un error
    else
      puts 'All EducationLevels are valid!'
    end
  end

  desc 'Check data integrity for Insurer records'
  task check_insurers: :environment do
    invalid_insurers = Insurer.find_each.select { |insurer| !insurer.valid? }

    if invalid_insurers.any?
      puts "Found #{invalid_insurers.count} invalid insurers:"
      invalid_insurers.each do |insurer|
        puts "insurers ID #{insurer.id} is invalid: ' +
          '#{insurer.errors.full_messages.join(', ')}"
      end
      exit 1 # Indica que hubo un error
    else
      puts 'All Insurers are valid!'
    end
  end

  desc 'Check data integrity for MaritalStatus records'
  task check_marital_statuses: :environment do
    invalid_marital_statuses = MaritalStatus.find_each.select do |marital_status|
      !marital_status.valid?
    end

    if invalid_marital_statuses.any?
      puts "Found #{invalid_marital_statuses.count} invalid marital_statuses:"
      invalid_marital_statuses.each do |marital_status|
        puts "marital_statuses ID #{marital_status.id} is invalid: ' +
          '#{marital_status.errors.full_messages.join(', ')}"
      end
      exit 1 # Indica que hubo un error
    else
      puts 'All MaritalStatuses are valid!'
    end
  end

  desc 'Check data integrity for MedicalNote records'
  task check_medical_notes: :environment do
    invalid_medical_notes = MedicalNote.find_each.select { |medical_note| !medical_note.valid? }

    if invalid_medical_notes.any?
      puts "Found #{invalid_medical_notes.count} invalid medical_notes:"
      invalid_medical_notes.each do |medical_note|
        puts "medical_notes ID #{medical_note.id} is invalid: ' +
          '#{medical_note.errors.full_messages.join(', ')}"
      end
      exit 1 # Indica que hubo un error
    else
      puts 'All MedicalNotes are valid!'
    end
  end

  desc 'Check data integrity for Patient records'
  task check_patients: :environment do
    invalid_patients = Patient.find_each.select { |patient| !patient.valid? }

    if invalid_patients.any?
      puts "Found #{invalid_patients.count} invalid patients:"
      invalid_patients.each do |patient|
        puts "patients ID #{patient.id} is invalid: ' +
          '#{patient.errors.full_messages.join(', ')}"
      end
      exit 1 # Indica que hubo un error
    else
      puts 'All Patients are valid!'
    end
  end
end
