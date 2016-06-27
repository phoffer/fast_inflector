# require "bundler/gem_tasks"
# require "rspec/core/rake_task"

# RSpec::Core::RakeTask.new(:spec)

# task :default => :spec

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test

desc "compile the Crystal native extensions"
task :compile do
  puts "compiling native extensions"
  `cd ext/fast_inflector && crystal deps && make clean && make`
end

desc "cleaning up compiled binaries"
task :clean do
  puts "cleaning up extensions"
  `cd ext && make clean`
end


task :console do
  require 'irb'
  require 'irb/completion'
  require 'fast_inflector' # You know what to do.
  ARGV.clear
  IRB.start
end