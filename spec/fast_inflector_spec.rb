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


  describe "pluralize_plurals" do
    it "doesn't re-pluralize plural words" do
      expect(ActiveSupport::Inflector.pluralize("plurals")).to eq("plurals")
      expect(ActiveSupport::Inflector.pluralize("Plurals")).to eq("Plurals")
      expect(ActiveSupport::Inflector.pluralize("words")).to eq("words")
      expect(ActiveSupport::Inflector.pluralize("Words")).to eq("Words")
      expect(ActiveSupport::Inflector.pluralize("posts")).to eq("posts")
      expect(ActiveSupport::Inflector.pluralize("Posts")).to eq("Posts")
    end
  end

  describe "pluralize_empty_string" do
    it 'works' do
      expect(ActiveSupport::Inflector.pluralize("")).to eq("")
    end
  end

  describe "built-in uncountables" do
    ActiveSupport::Inflector.inflections.uncountables.each do |word|
      it "test_uncountability_of_#{word}" do
        expect(ActiveSupport::Inflector.singularize(word)).to eq(word)
        expect(ActiveSupport::Inflector.pluralize(word)).to eq(word)
        expect(ActiveSupport::Inflector.singularize(word)).to eq(ActiveSupport::Inflector.pluralize(word))
      end
    end
  end

  describe "uncountable" do
    it "uncountable_word_is_not_greedy" do
      

      uncountable_word = "ors"
      countable_word = "sponsor"

      ActiveSupport::Inflector.inflections.uncountable(uncountable_word)

      expect(ActiveSupport::Inflector.singularize(uncountable_word)).to  eq(uncountable_word)
      expect(ActiveSupport::Inflector.pluralize(uncountable_word)).to    eq(uncountable_word)

      expect(ActiveSupport::Inflector.singularize(countable_word)).to    eq("sponsor")
      expect(ActiveSupport::Inflector.pluralize(countable_word)).to      eq("sponsors")
    end
  end

  describe "singular to plural" do    
    SingularToPlural.each do |singular, plural|
      it "pluralize '#{singular}' should == '#{plural}'" do
        expect(ActiveSupport::Inflector.pluralize(singular)).to            eq(plural)
        expect(ActiveSupport::Inflector.pluralize(singular.capitalize)).to eq(plural.capitalize)
      end
    end

    SingularToPlural.each do |singular, plural|
      it "singularize '#{plural}' should == '#{singular}'" do
        expect(ActiveSupport::Inflector.singularize(plural)).to            eq(singular)
        expect(ActiveSupport::Inflector.singularize(plural.capitalize)).to eq(singular.capitalize)
      end
    end
  end

  SingularToPlural.each do |singular, plural|
    it "pluralizing #{plural} should not change" do
      expect(ActiveSupport::Inflector.pluralize(plural)).to                eq(plural)
      expect(ActiveSupport::Inflector.pluralize(plural.capitalize)).to     eq(plural.capitalize)
    end

    it "singularizing #{singular} should not change" do
      expect(ActiveSupport::Inflector.singularize(singular)).to            eq(singular)
      expect(ActiveSupport::Inflector.singularize(singular.capitalize)).to eq(singular.capitalize)
    end
  end


  describe "overwrite_previous_inflectors" do
    it "should overwrite inflectors" do
      expect(ActiveSupport::Inflector.singularize("series")).to eq("series")
      ActiveSupport::Inflector.inflections.singular "series", "serie"
      expect(ActiveSupport::Inflector.singularize("series")).to eq("serie")
    end
  end

  describe "mixture to title case" do
    MixtureToTitleCase.each do |before, titleized|
      it "titleize '#{before}' => '#{titleized}'" do
        expect(ActiveSupport::Inflector.titleize(before.to_s).encoding).to eq(titleized.to_s.encoding)
        expect(ActiveSupport::Inflector.titleize(before.to_s)).to eq(titleized.to_s)
      end
    end
  end

  describe "camelize" do
    CamelToUnderscore.each do |camel, underscore|
      it "works for #{camel.inspect} => #{underscore.inspect}" do
        expect(ActiveSupport::Inflector.camelize(underscore)).to eq(camel)
      end
    end
    it "camelize_with_lower_downcases_the_first_letter" do
      expect(ActiveSupport::Inflector.camelize("Capital", false)).to eq("capital")
    end

    it "camelize_with_underscores" do
      expect(ActiveSupport::Inflector.camelize("Camel_Case")).to     eq("CamelCase")
    end
  end


  describe "acronyms" do
    it "works" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.acronym("API")
        inflect.acronym("HTML")
        inflect.acronym("HTTP")
        inflect.acronym("RESTful")
        inflect.acronym("W3C")
        inflect.acronym("PhD")
        inflect.acronym("RoR")
        inflect.acronym("SSL")
      end

      #  camelize             underscore            humanize              titleize
      [
        ["API",               "api",                "API",                "API"],
        ["APIController",     "api_controller",     "API controller",     "API Controller"],
        ["Nokogiri::HTML",    "nokogiri/html",      "Nokogiri/HTML",      "Nokogiri/HTML"],
        ["HTTPAPI",           "http_api",           "HTTP API",           "HTTP API"],
        ["HTTP::Get",         "http/get",           "HTTP/get",           "HTTP/Get"],
        ["SSLError",          "ssl_error",          "SSL error",          "SSL Error"],
        ["RESTful",           "restful",            "RESTful",            "RESTful"],
        ["RESTfulController", "restful_controller", "RESTful controller", "RESTful Controller"],
        ["Nested::RESTful",   "nested/restful",     "Nested/RESTful",     "Nested/RESTful"],
        ["IHeartW3C",         "i_heart_w3c",        "I heart W3C",        "I Heart W3C"],
        ["PhDRequired",       "phd_required",       "PhD required",       "PhD Required"],
        ["IRoRU",             "i_ror_u",            "I RoR u",            "I RoR U"],
        ["RESTfulHTTPAPI",    "restful_http_api",   "RESTful HTTP API",   "RESTful HTTP API"],
        ["HTTP::RESTful",     "http/restful",       "HTTP/RESTful",       "HTTP/RESTful"],
        ["HTTP::RESTfulAPI",  "http/restful_api",   "HTTP/RESTful API",   "HTTP/RESTful API"],
        ["APIRESTful",        "api_restful",        "API RESTful",        "API RESTful"],

        # misdirection
        ["Capistrano",        "capistrano",         "Capistrano",       "Capistrano"],
        ["CapiController",    "capi_controller",    "Capi controller",  "Capi Controller"],
        ["HttpsApis",         "https_apis",         "Https apis",       "Https Apis"],
        ["Html5",             "html5",              "Html5",            "Html5"],
        ["Restfully",         "restfully",          "Restfully",        "Restfully"],
        ["RoRails",           "ro_rails",           "Ro rails",         "Ro Rails"]
      ].each do |arr|
        camel, under, human, title = arr
        expect(ActiveSupport::Inflector.camelize(under)).to    eq(camel)
        expect(ActiveSupport::Inflector.camelize(camel)).to    eq(camel)
        expect(ActiveSupport::Inflector.underscore(under)).to  eq(under)
        expect(ActiveSupport::Inflector.underscore(camel)).to  eq(under)
        expect(ActiveSupport::Inflector.titleize(under)).to    eq(title)
        expect(ActiveSupport::Inflector.titleize(camel)).to    eq(title)
        expect(ActiveSupport::Inflector.humanize(under)).to    eq(human)
      end
    end
  end

  describe "acronyms" do
    it "should camelize acronyms" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.acronym("API")
        inflect.acronym("LegacyApi")
      end

      expect(ActiveSupport::Inflector.camelize("legacyapi")).to      eq("LegacyApi")
      expect(ActiveSupport::Inflector.camelize("legacy_api")).to     eq("LegacyAPI")
      expect(ActiveSupport::Inflector.camelize("some_legacyapi")).to eq("SomeLegacyApi")
      expect(ActiveSupport::Inflector.camelize("nonlegacyapi")).to   eq("Nonlegacyapi")
    end
    it "acronyms_camelize_lower" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.acronym("API")
        inflect.acronym("HTML")
      end

      expect(ActiveSupport::Inflector.camelize("html_api", false)).to eq("htmlAPI")
      expect(ActiveSupport::Inflector.camelize("htmlAPI", false)).to  eq("htmlAPI")
      expect(ActiveSupport::Inflector.camelize("HTMLAPI", false)).to  eq("htmlAPI")
    end
    it "underscore_acronym_sequence" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.acronym("API")
        inflect.acronym("JSON")
        inflect.acronym("HTML")
      end

      expect(ActiveSupport::Inflector.underscore("JSONHTMLAPI")).to eq("json_html_api")
    end
  end



  describe "underscore" do
    it "should work" do
      CamelToUnderscore.each do |camel, underscore|
        expect(ActiveSupport::Inflector.underscore(camel)).to eq(underscore)
      end
      CamelToUnderscoreWithoutReverse.each do |camel, underscore|
        expect(ActiveSupport::Inflector.underscore(camel)).to eq(underscore)
      end
    end
  end

  describe "camelize_with_module" do
    CamelWithModuleToUnderscoreWithSlash.each do |camel, underscore|
      it "camelizes #{underscore} => #{camel}" do
        expect(ActiveSupport::Inflector.camelize(underscore)).to eq(camel)
      end
    end
  end

  describe "underscore_with_slashes" do
    CamelWithModuleToUnderscoreWithSlash.each do |camel, underscore|
      it "underscores #{camel} => #{underscore}" do
        expect(ActiveSupport::Inflector.underscore(camel)).to eq(underscore)
      end
    end
  end

  describe "demodulize" do
    it "MyApplication::Billing::Account" do
      expect(ActiveSupport::Inflector.demodulize("MyApplication::Billing::Account")).to eq("Account")
    end
    it "Account" do
      expect(ActiveSupport::Inflector.demodulize("Account")).to                         eq("Account")
    end
    it "::Account" do
      expect(ActiveSupport::Inflector.demodulize("::Account")).to                       eq("Account")
    end
    it "" do
      expect(ActiveSupport::Inflector.demodulize("")).to                                eq("")
    end
  end

  describe "deconstantize" do
    it "works with 3 levels" do
      expect(ActiveSupport::Inflector.deconstantize("MyApplication::Billing::Account")).to   eq("MyApplication::Billing")
      expect(ActiveSupport::Inflector.deconstantize("::MyApplication::Billing::Account")).to eq("::MyApplication::Billing")
    end

    it "works with 2 levels" do
      expect(ActiveSupport::Inflector.deconstantize("MyApplication::Billing")).to            eq("MyApplication")
      expect(ActiveSupport::Inflector.deconstantize("::MyApplication::Billing")).to          eq("::MyApplication")
    end

    it "works with one level" do
      expect(ActiveSupport::Inflector.deconstantize("Account")).to                           eq("")
      expect(ActiveSupport::Inflector.deconstantize("::Account")).to                         eq("")
      expect(ActiveSupport::Inflector.deconstantize("")).to                                  eq("")
    end
  end

  describe "foreign_key" do
    ClassNameToForeignKeyWithUnderscore.each do |klass, foreign_key|
      it "converts classname #{klass} => #{foreign_key} with underscore" do
        expect(ActiveSupport::Inflector.foreign_key(klass)).to        eq(foreign_key)
      end
    end

    ClassNameToForeignKeyWithoutUnderscore.each do |klass, foreign_key|
      it "converts classname #{klass} => #{foreign_key} without underscore" do
        expect(ActiveSupport::Inflector.foreign_key(klass, false)).to eq(foreign_key)
      end
    end
  end

  describe "tableize" do
    ClassNameToTableName.each do |class_name, table_name|
      it "converts class_name to table_name: #{class_name} => #{table_name}" do
        expect(ActiveSupport::Inflector.tableize(class_name)).to eq(table_name)
      end
    end
  end

  describe "classify" do
    ClassNameToTableName.each do |class_name, table_name|
      it "classifies #{class_name.inspect} => #{table_name.inspect}" do
        expect(ActiveSupport::Inflector.classify(table_name)).to                   eq(class_name)
        expect(ActiveSupport::Inflector.classify("table_prefix." + table_name)).to eq(class_name)
      end
    end

    it "classify with symbol" do
      expect(ActiveSupport::Inflector.classify(:foo_bars)).to eq("FooBar")
    end

    it "classify with leading schema_name" do
      expect(ActiveSupport::Inflector.classify("schema.foo_bar")).to eq("FooBar")
    end
  end

  describe "#humanize" do
    it "humanize" do
      UnderscoreToHuman.each do |underscore, human|
        expect(ActiveSupport::Inflector.humanize(underscore)).to eq(human)
      end
    end

    it "humanize_without_capitalize" do
      UnderscoreToHumanWithoutCapitalize.each do |underscore, human|
        expect(ActiveSupport::Inflector.humanize(underscore, capitalize: false)).to eq(human)
      end
    end

    it "humanize_by_rule" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.human(/_cnt$/i, "\\1_count")
        inflect.human(/^prefx_/i, "\\1")
      end
      expect(ActiveSupport::Inflector.humanize("jargon_cnt")).to eq("Jargon count")
      expect(ActiveSupport::Inflector.humanize("prefx_request")).to eq("Request")
    end

    it "humanize_by_string" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.human("col_rpted_bugs", "Reported bugs")
      end
      expect(ActiveSupport::Inflector.humanize("col_rpted_bugs")).to eq("Reported bugs")
      expect(ActiveSupport::Inflector.humanize("COL_rpted_bugs")).to eq("Col rpted bugs")
    end
  end

  describe "ordinal" do
    OrdinalNumbers.each do |number, ordinalized|
      it "gets ordinal for #{number} => #{ordinalized}" do
        expect(number + ActiveSupport::Inflector.ordinal(number)).to eq(ordinalized)
      end
    end
  end

  describe "ordinalize" do
    OrdinalNumbers.each do |number, ordinalized|
      it "ordinalizes #{number} => #{ordinalized}" do
        expect(ActiveSupport::Inflector.ordinalize(number)).to eq(ordinalized)
      end
    end
  end

  describe "#dasherize" do
    describe "dasherizes correctly" do
      UnderscoresToDashes.each do |underscored, dasherized|
        it "dasherizes #{underscored} => #{dasherized}" do
          expect(ActiveSupport::Inflector.dasherize(underscored)).to eq(dasherized)
        end
      end
    end

    describe "underscore_as_reverse_of_dasherize" do
      UnderscoresToDashes.each_key do |underscored|
        it "dasherizes and underscores back to original #{underscored}" do
          expect(ActiveSupport::Inflector.underscore(ActiveSupport::Inflector.dasherize(underscored))).to eq(underscored)
        end
      end
    end
  end

  describe "camelize" do
    UnderscoreToLowerCamel.each do |underscored, lower_camel|
      it "underscore_to_lower_camel #{underscored.inspect} => #{lower_camel.inspect}" do
        expect(ActiveSupport::Inflector.camelize(underscored, false)).to eq(lower_camel)
      end
    end
    SymbolToLowerCamel.each do |symbol, lower_camel|
      it "symbol_to_lower_camel #{symbol.inspect} => #{lower_camel.inspect}" do
        expect(ActiveSupport::Inflector.camelize(symbol, false)).to eq(lower_camel)
      end
    end
  end

  describe "inflector_locality" do
    it "should work" do
      ActiveSupport::Inflector.inflections(:es) do |inflect|
        inflect.plural(/$/, "s")
        inflect.plural(/z$/i, "ces")

        inflect.singular(/s$/, "")
        inflect.singular(/es$/, "")

        inflect.irregular("el", "los")
      end

      expect("hijos").to eq(ActiveSupport::Inflector.pluralize("hijo", :es))
      expect("luces").to eq(ActiveSupport::Inflector.pluralize("luz", :es))
      expect("luzs").to  eq(ActiveSupport::Inflector.pluralize("luz"))

      expect("sociedad").to  eq(ActiveSupport::Inflector.singularize("sociedades", :es))
      expect("sociedade").to eq(ActiveSupport::Inflector.singularize("sociedades"))

      expect("los").to eq(ActiveSupport::Inflector.pluralize("el", :es))
      expect("els").to eq(ActiveSupport::Inflector.pluralize("el"))

      ActiveSupport::Inflector.inflections(:es) { |inflect| inflect.clear }

      expect(ActiveSupport::Inflector.inflections(:es).plurals.size).to   eq(0)
      expect(ActiveSupport::Inflector.inflections(:es).singulars.size).to eq(0)
      expect(ActiveSupport::Inflector.inflections.plurals.size).not_to    eq(0)
      expect(ActiveSupport::Inflector.inflections.singulars.size).not_to  eq(0)
    end
  end

  describe "clear inflectors" do
    it "clears all by defulat" do
      ActiveSupport::Inflector.inflections do |inflect|
        # ensure any data is present
        inflect.plural(/(quiz)$/i, "\\1zes")
        inflect.singular(/(database)s$/i, "\\1")
        inflect.uncountable("series")
        inflect.human("col_rpted_bugs", "Reported bugs")

        inflect.clear
        expect(inflect.plurals.size).to      eq(0)
        expect(inflect.singulars.size).to    eq(0)
        expect(inflect.uncountables.size).to eq(0)
        expect(inflect.humans.size).to       eq(0)
      end
    end
    it "clears all explicitly" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.plural(/(quiz)$/i, "\\1zes")
        inflect.singular(/(database)s$/i, "\\1")
        inflect.uncountable("series")
        inflect.human("col_rpted_bugs", "Reported bugs")

        inflect.clear :all
        expect(inflect.plurals.size).to      eq(0)
        expect(inflect.singulars.size).to    eq(0)
        expect(inflect.uncountables.size).to eq(0)
        expect(inflect.humans.size).to       eq(0)
      end
    end
    it "clears individual manually" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.plural(/(quiz)$/i, "\\1zes")
        inflect.singular(/(database)s$/i, "\\1")
        inflect.uncountable("series")
        inflect.human("col_rpted_bugs", "Reported bugs")

        inflect.clear(:plurals)
        inflect.clear(:singulars)
        inflect.clear(:uncountables)
        inflect.clear(:humans)
        inflect.clear(:acronyms)

        expect(inflect.plurals.size).to      eq(0)
        expect(inflect.singulars.size).to    eq(0)
        expect(inflect.uncountables.size).to eq(0)
        expect(inflect.humans.size).to       eq(0)
        expect(inflect.acronyms.size).to     eq(0)
      end
    end
  end

  describe 'irregularities' do
    Irregularities.each do |singular, plural|
      it "test irregularity between #{singular.inspect} => #{plural.inspect}" do
        ActiveSupport::Inflector.inflections do |inflect|
          inflect.irregular(singular, plural)
          expect(ActiveSupport::Inflector.singularize(plural)).to eq(singular)
          expect(ActiveSupport::Inflector.pluralize(singular)).to eq(plural)
        end
      end
    end
    Irregularities.each do |singular, plural|
      it "test pluralize of irregularity #{plural.inspect} should be the same" do
        ActiveSupport::Inflector.inflections do |inflect|
          inflect.irregular(singular, plural)
          expect(ActiveSupport::Inflector.pluralize(plural)).to eq(plural)
        end
      end
    end
    Irregularities.each do |singular, plural|
      it "test singularize of irregularity #{singular.inspect} should be the same"  do
        ActiveSupport::Inflector.inflections do |inflect|
          inflect.irregular(singular, plural)
          expect(ActiveSupport::Inflector.singularize(singular)).to eq(singular)
        end
      end
    end
  end

  describe 'clearing inflectors' do
    
    [ :all, [] ].each do |scope|
      ActiveSupport::Inflector.inflections do |inflect|
        it "test clear inflections with #{scope.kind_of?(Array) ? "no_arguments" : scope}"  do
          # save all the inflections
          singulars, plurals, uncountables = inflect.singulars, inflect.plurals, inflect.uncountables

          # clear all the inflections
          inflect.clear(*scope)

          expect(inflect.singulars).to eq([])
          expect(inflect.plurals).to eq([])
          expect(inflect.uncountables).to eq([])

          # restore all the inflections
          singulars.reverse_each { |singular| inflect.singular(*singular) }
          plurals.reverse_each   { |plural|   inflect.plural(*plural) }
          inflect.uncountable(uncountables)

          expect(inflect.singulars).to eq(singulars)
          expect(inflect.plurals).to eq(plurals)
          expect(inflect.uncountables).to eq(uncountables)
        end
      end
    end
  end


  describe "inflections_with_uncountable_words" do
    it "should not count HTTP" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.uncountable "HTTP"
      end
      expect(ActiveSupport::Inflector.pluralize("HTTP")).to eq("HTTP")
    end
  end
end
