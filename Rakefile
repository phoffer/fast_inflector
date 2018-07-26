require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

# require "rake/extensiontask"

# task :build => :compile

# Rake::ExtensionTask.new("fast_inflector") do |ext|
#   ext.lib_dir = "lib/fast_inflector"
# end

task :default => [:clobber, :compile, :test]


desc "compile the Crystal native extensions"
task :compile do
  puts "compiling native extensions"
  `cd ext/fast_inflector && crystal deps && make clean && make`
end

desc "cleaning up compiled binaries"
task :clean do
  puts "cleaning up extensions"
  `cd ext/fast_inflector && make clean`
end


desc "clean up all unnecessary crystal files"
task :deep_clean do
  puts "cleaning up extension dir"
  `cd ext/fast_inflector && make deep_clean`
end


task :console do
  require 'irb'
  require 'irb/completion'
  require 'fast_inflector'
  ARGV.clear
  IRB.start
end