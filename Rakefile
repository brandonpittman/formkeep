require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'yard'
require 'rubocop/rake_task'

desc 'Run RuboCop on the lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  # only show the files with failures
  task.formatters = ['files']
  # don't abort rake on failure
  task.fail_on_error = false
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

YARD::Rake::YardocTask.new do |t|
end
