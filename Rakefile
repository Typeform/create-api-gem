require 'bundler/gem_tasks'
require 'rake/testtask'

desc 'Start up the irb console with the gem required'
task :console do
  exec 'irb -r create_api_gem -I ./lib'
end

desc 'Run the tests'
task default: :test

Rake::TestTask.new do |t|
  t.libs << 'test'
end
