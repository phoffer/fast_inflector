require 'spec_helper'

# describe FastInflector do
#   it 'has a version number' do
#     expect(FastInflector::VERSION).not_to be nil
#   end

#   it 'does something useful' do
#     expect(false).to eq(true)
#   end
# end

# require "./spec_helper"
require "inflector_test_cases"
include InflectorTestCases

describe "Inflector" do

  # def setup
  #   # Dups the singleton before each test, restoring the original inflections later.
  #   #
  #   # This helper is implemented by setting @__instance__ because in some tests
  #   # there are module functions that access ActiveSupport::Inflector.inflections,
  #   # so we need to replace the singleton itself.
  #   @original_inflections = Inflector::Inflections.instance_variable_get(:@__instance__)[:en]
  #   Inflector::Inflections.instance_variable_set(:@__instance__, en: @original_inflections.dup)
  # end

  # def teardown
  #   Inflector::Inflections.instance_variable_set(:@__instance__, en: @original_inflections)
  # end


  describe "utf stuff" do
    let(:words) { ["¿por qué?", "Fred’s", "Fred`s"] }
    it "titleizes" do
      # puts "before, in ruby: #{"¿por qué?"}"
      # puts ActiveSupport::Inflector.method(:titleize).source_location
      # puts "method return: " + ActiveSupport::Inflector.titleize("¿por qué?").encoding
      # puts "after, in ruby: #{"¿por qué?".encoding}"
      # puts "before, in ruby: #{"Fred’s"}"
      # puts ActiveSupport::Inflector.method(:titleize).source_location
      # puts "method return: " + ActiveSupport::Inflector.titleize("Fred’s").encoding
      # puts "after, in ruby: #{"Fred’s".encoding}"
      # puts "before, in ruby: #{"Fred`s"}"
      # puts ActiveSupport::Inflector.method(:titleize).source_location
      # puts "method return: " + ActiveSupport::Inflector.titleize("Fred`s").encoding
      # puts "after, in ruby: #{"Fred`s".encoding}"
    end
  end
end
