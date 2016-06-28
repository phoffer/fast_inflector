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
      (ActiveSupport::Inflector.pluralize("plurals")).should eq("plurals")
      (ActiveSupport::Inflector.pluralize("Plurals")).should eq("Plurals")
      (ActiveSupport::Inflector.pluralize("words")).should eq("words")
      (ActiveSupport::Inflector.pluralize("Words")).should eq("Words")
      (ActiveSupport::Inflector.pluralize("posts")).should eq("posts")
      (ActiveSupport::Inflector.pluralize("Posts")).should eq("Posts")
    end
  end

  describe "pluralize_empty_string" do
    it 'works' do
      (ActiveSupport::Inflector.pluralize("")).should eq("")
    end
  end

  describe "built-in uncountables" do
    ActiveSupport::Inflector.inflections.uncountables.each do |word|
      it "test_uncountability_of_#{word}" do
        (ActiveSupport::Inflector.singularize(word)).should eq(word)
        (ActiveSupport::Inflector.pluralize(word)).should eq(word)
        (ActiveSupport::Inflector.singularize(word)).should eq(ActiveSupport::Inflector.pluralize(word))
      end
    end
  end

  describe "uncountable" do
    it "uncountable_word_is_not_greedy" do
      

      uncountable_word = "ors"
      countable_word = "sponsor"

      ActiveSupport::Inflector.inflections.uncountables << uncountable_word

      (ActiveSupport::Inflector.singularize(uncountable_word)).should  eq(uncountable_word)
      (ActiveSupport::Inflector.pluralize(uncountable_word)).should    eq(uncountable_word)

      (ActiveSupport::Inflector.singularize(countable_word)).should    eq("sponsor")
      (ActiveSupport::Inflector.pluralize(countable_word)).should      eq("sponsors")
    end
  end

  describe "singular to plural" do    
    SingularToPlural.each do |singular, plural|
      it "pluralize '#{singular}' should == '#{plural}'" do
        (ActiveSupport::Inflector.pluralize(singular)).should            eq(plural)
        (ActiveSupport::Inflector.pluralize(singular.capitalize)).should eq(plural.capitalize)
      end
    end

    SingularToPlural.each do |singular, plural|
      it "singularize '#{plural}' should == '#{singular}'" do
        (ActiveSupport::Inflector.singularize(plural)).should            eq(singular)
        (ActiveSupport::Inflector.singularize(plural.capitalize)).should eq(singular.capitalize)
      end
    end
  end

  SingularToPlural.each do |singular, plural|
    it "pluralizing #{plural} should not change" do
      (ActiveSupport::Inflector.pluralize(plural)).should                eq(plural)
      (ActiveSupport::Inflector.pluralize(plural.capitalize)).should     eq(plural.capitalize)
    end

    it "singularizing #{singular} should not change" do
      (ActiveSupport::Inflector.singularize(singular)).should            eq(singular)
      (ActiveSupport::Inflector.singularize(singular.capitalize)).should eq(singular.capitalize)
    end
  end


  describe "overwrite_previous_inflectors" do
    it "should overwrite inflectors" do
      (ActiveSupport::Inflector.singularize("series")).should eq("series")
      ActiveSupport::Inflector.inflections.singular "series", "serie"
      (ActiveSupport::Inflector.singularize("series")).should eq("serie")
    end
  end

  describe "mixture to title case" do
    MixtureToTitleCase.each do |before, titleized|
      it "titleize '#{before}' => '#{titleized}'" do
        (ActiveSupport::Inflector.titleize(before.to_s)).should eq(titleized.to_s)
      end
    end
  end

  describe "camelize" do
    it 'works' do
      CamelToUnderscore.each do |camel, underscore|
        (ActiveSupport::Inflector.camelize(underscore)).should eq(camel)
      end
    end
    it "camelize_with_lower_downcases_the_first_letter" do
      (ActiveSupport::Inflector.camelize("Capital", false)).should eq("capital")
    end

    it "camelize_with_underscores" do
      (ActiveSupport::Inflector.camelize("Camel_Case")).should     eq("CamelCase")
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
        (ActiveSupport::Inflector.camelize(under)).should    eq(camel)
        (ActiveSupport::Inflector.camelize(camel)).should    eq(camel)
        (ActiveSupport::Inflector.underscore(under)).should  eq(under)
        (ActiveSupport::Inflector.underscore(camel)).should  eq(under)
        (ActiveSupport::Inflector.titleize(under)).should    eq(title)
        (ActiveSupport::Inflector.titleize(camel)).should    eq(title)
        (ActiveSupport::Inflector.humanize(under)).should    eq(human)
      end
    end
  end

  describe "acronyms" do
    it "should camelize acronyms" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.acronym("API")
        inflect.acronym("LegacyApi")
      end

      (ActiveSupport::Inflector.camelize("legacyapi")).should      eq("LegacyApi")
      (ActiveSupport::Inflector.camelize("legacy_api")).should     eq("LegacyAPI")
      (ActiveSupport::Inflector.camelize("some_legacyapi")).should eq("SomeLegacyApi")
      (ActiveSupport::Inflector.camelize("nonlegacyapi")).should   eq("Nonlegacyapi")
    end
    it "acronyms_camelize_lower" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.acronym("API")
        inflect.acronym("HTML")
      end

      (ActiveSupport::Inflector.camelize("html_api", false)).should eq("htmlAPI")
      (ActiveSupport::Inflector.camelize("htmlAPI", false)).should  eq("htmlAPI")
      (ActiveSupport::Inflector.camelize("HTMLAPI", false)).should  eq("htmlAPI")
    end
    it "underscore_acronym_sequence" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.acronym("API")
        inflect.acronym("JSON")
        inflect.acronym("HTML")
      end

      (ActiveSupport::Inflector.underscore("JSONHTMLAPI")).should eq("json_html_api")
    end
  end



  describe "underscore" do
    it "should work" do
      CamelToUnderscore.each do |camel, underscore|
        (ActiveSupport::Inflector.underscore(camel)).should eq(underscore)
      end
      CamelToUnderscoreWithoutReverse.each do |camel, underscore|
        (ActiveSupport::Inflector.underscore(camel)).should eq(underscore)
      end
    end
  end

  describe "camelize_with_module" do
    CamelWithModuleToUnderscoreWithSlash.each do |camel, underscore|
      it "camelizes #{underscore} => #{camel}" do
        (ActiveSupport::Inflector.camelize(underscore)).should eq(camel)
      end
    end
  end

  describe "underscore_with_slashes" do
    CamelWithModuleToUnderscoreWithSlash.each do |camel, underscore|
      it "underscores #{camel} => #{underscore}" do
        (ActiveSupport::Inflector.underscore(camel)).should eq(underscore)
      end
    end
  end

  describe "demodulize" do
    it "MyApplication::Billing::Account" do
      (ActiveSupport::Inflector.demodulize("MyApplication::Billing::Account")).should eq("Account")
    end
    it "Account" do
      (ActiveSupport::Inflector.demodulize("Account")).should                         eq("Account")
    end
    it "::Account" do
      (ActiveSupport::Inflector.demodulize("::Account")).should                       eq("Account")
    end
    it "" do
      (ActiveSupport::Inflector.demodulize("")).should                                eq("")
    end
  end

  describe "deconstantize" do
    it "works with 3 levels" do
      (ActiveSupport::Inflector.deconstantize("MyApplication::Billing::Account")).should   eq("MyApplication::Billing")
      (ActiveSupport::Inflector.deconstantize("::MyApplication::Billing::Account")).should eq("::MyApplication::Billing")
    end

    it "works with 2 levels" do
      (ActiveSupport::Inflector.deconstantize("MyApplication::Billing")).should            eq("MyApplication")
      (ActiveSupport::Inflector.deconstantize("::MyApplication::Billing")).should          eq("::MyApplication")
    end

    it "works with one level" do
      (ActiveSupport::Inflector.deconstantize("Account")).should                           eq("")
      (ActiveSupport::Inflector.deconstantize("::Account")).should                         eq("")
      (ActiveSupport::Inflector.deconstantize("")).should                                  eq("")
    end
  end

  describe "foreign_key" do
    ClassNameToForeignKeyWithUnderscore.each do |klass, foreign_key|
      it "converts classname #{klass} => #{foreign_key} with underscore" do
        (ActiveSupport::Inflector.foreign_key(klass)).should        eq(foreign_key)
      end
    end

    ClassNameToForeignKeyWithoutUnderscore.each do |klass, foreign_key|
      it "converts classname #{klass} => #{foreign_key} without underscore" do
        (ActiveSupport::Inflector.foreign_key(klass, false)).should eq(foreign_key)
      end
    end
  end

  describe "tableize" do
    ClassNameToTableName.each do |class_name, table_name|
      it "converts class_name to table_name: #{class_name} => #{table_name}" do
        (ActiveSupport::Inflector.tableize(class_name)).should eq(table_name)
      end
    end
  end

  describe "classify" do
    it "handles base case" do
      ClassNameToTableName.each do |class_name, table_name|
        (ActiveSupport::Inflector.classify(table_name)).should                   eq(class_name)
        (ActiveSupport::Inflector.classify("table_prefix." + table_name)).should eq(class_name)
      end
    end

    it "classify with symbol" do
      (ActiveSupport::Inflector.classify(:foo_bars)).should eq("FooBar")
    end

    it "classify with leading schema_name" do
      (ActiveSupport::Inflector.classify("schema.foo_bar")).should eq("FooBar")
    end
  end

  describe "#humanize" do
    it "humanize" do
      UnderscoreToHuman.each do |underscore, human|
        (ActiveSupport::Inflector.humanize(underscore)).should eq(human)
      end
    end

    it "humanize_without_capitalize" do
      UnderscoreToHumanWithoutCapitalize.each do |underscore, human|
        (ActiveSupport::Inflector.humanize(underscore, capitalize: false)).should eq(human)
      end
    end

    it "humanize_by_rule" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.human(/_cnt$/i, "\\1_count")
        inflect.human(/^prefx_/i, "\\1")
      end
      (ActiveSupport::Inflector.humanize("jargon_cnt")).should eq("Jargon count")
      (ActiveSupport::Inflector.humanize("prefx_request")).should eq("Request")
    end

    it "humanize_by_string" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.human("col_rpted_bugs", "Reported bugs")
      end
      (ActiveSupport::Inflector.humanize("col_rpted_bugs")).should eq("Reported bugs")
      (ActiveSupport::Inflector.humanize("COL_rpted_bugs")).should eq("Col rpted bugs")
    end
  end

  describe "ordinal" do
    OrdinalNumbers.each do |number, ordinalized|
      it "gets ordinal for #{number} => #{ordinalized}" do
        (number + ActiveSupport::Inflector.ordinal(number)).should eq(ordinalized)
      end
    end
  end

  describe "ordinalize" do
    OrdinalNumbers.each do |number, ordinalized|
      it "ordinalizes #{number} => #{ordinalized}" do
        (ActiveSupport::Inflector.ordinalize(number)).should eq(ordinalized)
      end
    end
  end

  describe "#dasherize" do
    describe "dasherizes correctly" do
      UnderscoresToDashes.each do |underscored, dasherized|
        it "dasherizes #{underscored} => #{dasherized}" do
          (ActiveSupport::Inflector.dasherize(underscored)).should eq(dasherized)
        end
      end
    end

    describe "underscore_as_reverse_of_dasherize" do
      UnderscoresToDashes.each_key do |underscored|
        it "dasherizes and underscores back to original #{underscored}" do
          (ActiveSupport::Inflector.underscore(ActiveSupport::Inflector.dasherize(underscored))).should eq(underscored)
        end
      end
    end
  end

  describe "camelize" do
    it "underscore_to_lower_camel" do
      UnderscoreToLowerCamel.each do |underscored, lower_camel|
        (ActiveSupport::Inflector.camelize(underscored, false)).should eq(lower_camel)
      end
    end
    it "symbol_to_lower_camel" do
      SymbolToLowerCamel.each do |symbol, lower_camel|
        (ActiveSupport::Inflector.camelize(symbol, false)).should eq(lower_camel)
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

      ("hijos").should eq(ActiveSupport::Inflector.pluralize("hijo", :es))
      ("luces").should eq(ActiveSupport::Inflector.pluralize("luz", :es))
      ("luzs").should  eq(ActiveSupport::Inflector.pluralize("luz"))

      ("sociedad").should  eq(ActiveSupport::Inflector.singularize("sociedades", :es))
      ("sociedade").should eq(ActiveSupport::Inflector.singularize("sociedades"))

      ("los").should eq(ActiveSupport::Inflector.pluralize("el", :es))
      ("els").should eq(ActiveSupport::Inflector.pluralize("el"))

      ActiveSupport::Inflector.inflections(:es) { |inflect| inflect.clear }

      (ActiveSupport::Inflector.inflections(:es).plurals.size).should   eq(0)
      (ActiveSupport::Inflector.inflections(:es).singulars.size).should eq(0)
      (ActiveSupport::Inflector.inflections.plurals.size).should_not    eq(0)
      (ActiveSupport::Inflector.inflections.singulars.size).should_not  eq(0)
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
        (inflect.plurals.size).should      eq(0)
        (inflect.singulars.size).should    eq(0)
        (inflect.uncountables.size).should eq(0)
        (inflect.humans.size).should       eq(0)
      end
    end
    it "clears all explicitly" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.plural(/(quiz)$/i, "\\1zes")
        inflect.singular(/(database)s$/i, "\\1")
        inflect.uncountable("series")
        inflect.human("col_rpted_bugs", "Reported bugs")

        inflect.clear :all
        (inflect.plurals.size).should      eq(0)
        (inflect.singulars.size).should    eq(0)
        (inflect.uncountables.size).should eq(0)
        (inflect.humans.size).should       eq(0)
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

        (inflect.plurals.size).should      eq(0)
        (inflect.singulars.size).should    eq(0)
        (inflect.uncountables.size).should eq(0)
        (inflect.humans.size).should       eq(0)
        (inflect.acronyms.size).should     eq(0)
      end
    end
  end

  # Irregularities.each do |singular, plural|
  #   define_method("test_irregularity_between_#{singular}_and_#{plural}") do
  #     ActiveSupport::Inflector.inflections do |inflect|
  #       inflect.irregular(singular, plural)
  # (ActiveSupport::Inflector.singularize(plural)).should eq(singular)
  # (ActiveSupport::Inflector.pluralize(singular)).should eq(plural)
  #     end
  #   end
  # end

  # Irregularities.each do |singular, plural|
  #   define_method("test_pluralize_of_irregularity_#{plural}_should_be_the_same") do
  #     ActiveSupport::Inflector.inflections do |inflect|
  #       inflect.irregular(singular, plural)
  # (ActiveSupport::Inflector.pluralize(plural)).should eq(plural)
  #     end
  #   end
  # end

  # Irregularities.each do |singular, plural|
  #   define_method("test_singularize_of_irregularity_#{singular}_should_be_the_same") do
  #     ActiveSupport::Inflector.inflections do |inflect|
  #       inflect.irregular(singular, plural)
  # (ActiveSupport::Inflector.singularize(singular)).should eq(singular)
  #     end
  #   end
  # end

  # [ :all, [] ].each do |scope|
  #   ActiveSupport::Inflector.inflections do |inflect|
  #     define_method("test_clear_inflections_with_#{scope.kind_of?(Array) ? "no_arguments" : scope}") do
  #       # save all the inflections
  #       singulars, plurals, uncountables = inflect.singulars, inflect.plurals, inflect.uncountables

  #       # clear all the inflections
  #       inflect.clear(*scope)

  # (inflect.singulars).should eq([])
  # (inflect.plurals).should eq([])
  # (inflect.uncountables).should eq([])

  #       # restore all the inflections
  #       singulars.reverse_each { |singular| inflect.singular(*singular) }
  #       plurals.reverse_each   { |plural|   inflect.plural(*plural) }
  #       inflect.uncountable(uncountables)

  # (inflect.singulars).should eq(singulars)
  # (inflect.plurals).should eq(plurals)
  # (inflect.uncountables).should eq(uncountables)
  #     end
  #   end
  # end


  describe "inflections_with_uncountable_words" do
    it "should not count HTTP" do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.uncountable "HTTP"
      end
      (ActiveSupport::Inflector.pluralize("HTTP")).should eq("HTTP")
    end
  end
end
