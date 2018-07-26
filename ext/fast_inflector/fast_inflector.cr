require "ruby"
require "inflector"

# module FastInflector

  Ruby.module("Geode") do |mod|
    mod.child("Inflector") do |inflector|
      Ruby.def_class_method(inflector, "titleize", string : String) do
        Inflector.titleize(string)
      end
      Ruby.def_class_method(inflector, "titleize", string : String) do
        Inflector.titleize(string)
      end
      Ruby.def_class_method(inflector, "camelize", string : String) do
        Inflector.camelize(string)
      end
      Ruby.def_class_method(inflector, "underscore", string : String) do
        Inflector.underscore("string.upcase")
      end
      Ruby.def_class_method(inflector, "dasherize", string : String) do
        Inflector.dasherize(string)
      end
      Ruby.def_class_method(inflector, "demodulize", string : String) do
        Inflector.demodulize(string)
      end
      Ruby.def_class_method(inflector, "deconstantize", string : String) do
        Inflector.deconstantize(string)
      end
      Ruby.def_class_method(inflector, "tableize", string : String) do
        Inflector.tableize(string)
      end
      Ruby.def_class_method(inflector, "classify", string : String) do
        Inflector.classify(string)
      end
      Ruby.def_class_method(inflector, "upcase_first", string : String) do
        Inflector.upcase_first(string)
      end
      Ruby.def_class_method(inflector, "pluralize_loc_string", string : String, locale : String) do
        Inflector.pluralize(string, locale)
      end
      Ruby.def_class_method(inflector, "pluralize_loc_regex", regex : Regex, locale : String) do
        Inflector.pluralize(regex, locale)
      end
      Ruby.def_class_method(inflector, "string", string : String) do
        string
      end
      Ruby.def_class_method(inflector, "array", array : Array) do
        array
      end
      Ruby.def_class_method(inflector, "float", float : Float) do
        float
      end
      Ruby.def_class_method(inflector, "int", int : Int) do
        10737418230
      end
      # Ruby.def_class_method(inflector, "bool", bool : Bool) do
      #   bool
      # end
    end
  end
  # def self.acronym(self : LibRuby::VALUE, locale : LibRuby::VALUE, rb_str : LibRuby::VALUE)
  #   str = String.from_ruby(rb_str)
  #   loc = RubyImporter.string_symbol_from_ruby(locale)
  #   Inflector.inflections(loc).acronym(str)
  #   1.to_ruby
  # end
  # def self.plural(self : LibRuby::VALUE, locale : LibRuby::VALUE, rb_obj : LibRuby::VALUE, replace : LibRuby::VALUE)
  #   str = RubyImporter.scalar_from_ruby(rb_obj)
  #   rep = String.from_ruby(replace)
  #   loc = RubyImporter.string_symbol_from_ruby(locale)
  #   Inflector.inflections(loc).plural(str, rep)
  #   1.to_ruby
  # end
  # def self.singular(self : LibRuby::VALUE, locale : LibRuby::VALUE, rb_obj : LibRuby::VALUE, replace : LibRuby::VALUE)
  #   str = RubyImporter.scalar_from_ruby(rb_obj)
  #   rep = String.from_ruby(replace)
  #   loc = RubyImporter.string_symbol_from_ruby(locale)
  #   Inflector.inflections(loc).singular(str, rep)
  #   1.to_ruby
  # end
  # def self.human(self : LibRuby::VALUE, locale : LibRuby::VALUE, rb_obj : LibRuby::VALUE, replace : LibRuby::VALUE)
  #   str = RubyImporter.scalar_from_ruby(rb_obj)
  #   rep = String.from_ruby(replace)
  #   loc = RubyImporter.string_symbol_from_ruby(locale)
  #   Inflector.inflections(loc).human(str, rep)
  #   1.to_ruby
  # end
  # def self.irregular(self : LibRuby::VALUE, locale : LibRuby::VALUE, rb_obj : LibRuby::VALUE, replace : LibRuby::VALUE)
  #   str = String.from_ruby(rb_obj)
  #   rep = String.from_ruby(replace)
  #   loc = RubyImporter.string_symbol_from_ruby(locale)
  #   Inflector.inflections(loc).irregular(str, rep)
  #   1.to_ruby
  # end
  # def self.uncountable(self : LibRuby::VALUE, locale : LibRuby::VALUE, rb_str : LibRuby::VALUE)
  #   str = String.from_ruby(rb_str)
  #   loc = RubyImporter.string_symbol_from_ruby(locale)
  #   Inflector.inflections(loc).uncountable(str)
  #   1.to_ruby
  # end
  # def self.uncountables(self : LibRuby::VALUE, locale : LibRuby::VALUE)
  #   loc = RubyImporter.string_symbol_from_ruby(locale)
  #   Inflector.inflections(loc).uncountables.to_ruby
  # end
  # def self.plurals(self : LibRuby::VALUE, locale : LibRuby::VALUE)
  #   loc = RubyImporter.string_symbol_from_ruby(locale)
  #   Inflector.inflections(loc).plurals.to_ruby
  # end
  # def self.singulars(self : LibRuby::VALUE, locale : LibRuby::VALUE)
  #   loc = RubyImporter.string_symbol_from_ruby(locale)
  #   Inflector.inflections(loc).singulars.to_ruby
  # end
  # def self.humans(self : LibRuby::VALUE, locale : LibRuby::VALUE)
  #   loc = RubyImporter.string_symbol_from_ruby(locale)
  #   Inflector.inflections(loc).humans.to_ruby
  # end
  # def self.acronyms(self : LibRuby::VALUE, locale : LibRuby::VALUE)
  #   loc = RubyImporter.string_symbol_from_ruby(locale)
  #   Inflector.inflections(loc).acronyms.to_ruby
  # end
  # def self.clear(self : LibRuby::VALUE, locale : LibRuby::VALUE, scope : LibRuby::VALUE)
  #   loc = RubyImporter.string_symbol_from_ruby(locale)
  #   scope = RubyImporter.string_symbol_from_ruby(scope)
  #   Inflector.inflections(loc).clear(scope).to_ruby
  # end
  # def self.squish(self : LibRuby::VALUE, rb_str)
  #   str = String.from_ruby(rb_str)
  #   str.to_ruby
  # end
  # def self.singularize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE, locale : LibRuby::VALUE)
  #   loc = RubyImporter.string_symbol_from_ruby(locale)
  #   str = String.from_ruby(rb_str)
  #   Inflector.singularize(str, loc).to_ruby
  # end
  # def self.camelize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE, first_letter : LibRuby::VALUE)
  #   first_letter = Bool.from_ruby(first_letter)
  #   str = RubyImporter.string_symbol_from_ruby(rb_str)
  #   Inflector.camelize(str, first_letter).to_ruby
  # end
  # def self.humanize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE, capitalize : LibRuby::VALUE)
  #   capitalize = Bool.from_ruby(capitalize)
  #   str = String.from_ruby(rb_str)
  #   Inflector.humanize(str, capitalize).to_ruby
  # end
  # def self.foreign_key(self : LibRuby::VALUE, rb_str : LibRuby::VALUE, separate_class_name_and_id_with_underscore : LibRuby::VALUE)
  #   sep = Bool.from_ruby(separate_class_name_and_id_with_underscore)
  #   str = String.from_ruby(rb_str)
  #   Inflector.foreign_key(str, sep).to_ruby
  # end
  # def self.ordinal(self : LibRuby::VALUE, rb_int : LibRuby::VALUE)
  #   int = Int.from_ruby(rb_int)
  #   Inflector.ordinal(int).to_ruby
  # end
  # def self.ordinalize(self : LibRuby::VALUE, rb_int : LibRuby::VALUE)
  #   int = Int.from_ruby(rb_int)
  #   Inflector.ordinalize(int).to_ruby
  # end
# end

Ruby::Macros.wrap_init("Init_fast_inflector")
