require 'bundler/gem_tasks'
require 'rake/testtask'

task :console do
  exec 'irb -r create_api_gem -I ./lib'
end

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc 'Run tests'
task default: :test
