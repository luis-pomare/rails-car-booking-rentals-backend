# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

namespace :assets do
  task :precompile do
    # Dummy task that does nothing
    puts "Skipping assets precompile for API-only application."
  end
end
