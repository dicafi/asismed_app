# filepath: /Users/julioacevedo/Documents/Trabajo/Casuy/asismed_app/lib/tasks/data_integrity.rake
namespace :data_integrity do
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
      puts 'All users are valid!'
    end
  end
end
