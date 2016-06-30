require "inflector"
# struct Tuple(Regex, String)
struct Tuple
  def to_ruby
    [self.first, self.last].to_ruby
  end
end
module RubyImporter
  def self.string_symbol_from_ruby(obj : LibRuby::VALUE)
    klass_name = rb_class(obj)
    case klass_name
    when "String"
      String.from_ruby(obj)
    when "Symbol"
      RubySymbol.from_ruby(obj)
    else
      String.from_ruby(obj)
    end
  end
  def self.scalar_from_ruby(obj : LibRuby::VALUE)
    klass_name = rb_class(obj)
    case klass_name
    when "String"
      String.from_ruby(obj)
    when "Regexp"
      Regex.from_ruby(obj)
    else
      String.from_ruby(obj)
    end
  end
end
struct Bool
  def to_ruby
    Pointer(Void).new(self ? 20_u64 : 0_u64).as(LibRuby::VALUE)
  end
  def self.from_ruby(obj : LibRuby::VALUE)
    klass_name = RubyImporter.rb_class(obj)
    case klass_name
    when "TrueClass"
      true
    when "FalseClass"
      false
    end
  end
end
module Wrapper
  def self.acronym(self : LibRuby::VALUE, locale : LibRuby::VALUE, rb_str : LibRuby::VALUE)
    str = String.from_ruby(rb_str)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    Inflector.inflections(loc).acronym(str)
    1.to_ruby
  end
  def self.plural(self : LibRuby::VALUE, locale : LibRuby::VALUE, rb_obj : LibRuby::VALUE, replace : LibRuby::VALUE)
    str = RubyImporter.scalar_from_ruby(rb_obj)
    rep = String.from_ruby(replace)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    Inflector.inflections(loc).plural(str, rep)
    1.to_ruby
  end
  def self.singular(self : LibRuby::VALUE, locale : LibRuby::VALUE, rb_obj : LibRuby::VALUE, replace : LibRuby::VALUE)
    str = RubyImporter.scalar_from_ruby(rb_obj)
    rep = String.from_ruby(replace)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    Inflector.inflections(loc).singular(str, rep)
    1.to_ruby
  end
  def self.human(self : LibRuby::VALUE, locale : LibRuby::VALUE, rb_obj : LibRuby::VALUE, replace : LibRuby::VALUE)
    str = RubyImporter.scalar_from_ruby(rb_obj)
    rep = String.from_ruby(replace)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    Inflector.inflections(loc).human(str, rep)
    1.to_ruby
  end
  def self.irregular(self : LibRuby::VALUE, locale : LibRuby::VALUE, rb_obj : LibRuby::VALUE, replace : LibRuby::VALUE)
    str = String.from_ruby(rb_obj)
    rep = String.from_ruby(replace)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    Inflector.inflections(loc).irregular(str, rep)
    1.to_ruby
  end
  def self.uncountable(self : LibRuby::VALUE, locale : LibRuby::VALUE, rb_str : LibRuby::VALUE)
    str = String.from_ruby(rb_str)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    Inflector.inflections(loc).uncountable(str)
    1.to_ruby
  end
  def self.uncountables(self : LibRuby::VALUE, locale : LibRuby::VALUE)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    Inflector.inflections(loc).uncountables.to_ruby
  end
  def self.plurals(self : LibRuby::VALUE, locale : LibRuby::VALUE)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    Inflector.inflections(loc).plurals.to_ruby
  end
  def self.singulars(self : LibRuby::VALUE, locale : LibRuby::VALUE)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    Inflector.inflections(loc).singulars.to_ruby
  end
  def self.humans(self : LibRuby::VALUE, locale : LibRuby::VALUE)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    Inflector.inflections(loc).humans.to_ruby
  end
  def self.acronyms(self : LibRuby::VALUE, locale : LibRuby::VALUE)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    Inflector.inflections(loc).acronyms.to_ruby
  end
  def self.clear(self : LibRuby::VALUE, locale : LibRuby::VALUE, scope : LibRuby::VALUE)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    scope = RubyImporter.string_symbol_from_ruby(scope)
    Inflector.inflections(loc).clear(scope).to_ruby
  end
  def self.squish(self : LibRuby::VALUE, rb_str)
    str = String.from_ruby(rb_str)
    str.to_ruby
  end
  def self.pluralize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE, locale : LibRuby::VALUE)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    str = String.from_ruby(rb_str)
    Inflector.pluralize(str, loc).to_ruby
  end
  def self.singularize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE, locale : LibRuby::VALUE)
    loc = RubyImporter.string_symbol_from_ruby(locale)
    str = String.from_ruby(rb_str)
    Inflector.singularize(str, loc).to_ruby
  end
  def self.camelize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE, first_letter : LibRuby::VALUE)
    first_letter = Bool.from_ruby(first_letter)
    str = RubyImporter.string_symbol_from_ruby(rb_str)
    Inflector.camelize(str, first_letter).to_ruby
  end
  def self.titleize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE)
    str = String.from_ruby(rb_str)
    Inflector.titleize(str).to_ruby
  end
  def self.camelize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE)
    str = String.from_ruby(rb_str)
    Inflector.camelize(str).to_ruby
  end
  def self.underscore(self : LibRuby::VALUE, rb_str : LibRuby::VALUE)
    str = String.from_ruby(rb_str)
    Inflector.underscore(str).to_ruby
  end
  def self.dasherize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE)
    str = String.from_ruby(rb_str)
    Inflector.dasherize(str).to_ruby
  end
  def self.demodulize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE)
    str = String.from_ruby(rb_str)
    Inflector.demodulize(str).to_ruby
  end
  def self.deconstantize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE)
    str = String.from_ruby(rb_str)
    Inflector.deconstantize(str).to_ruby
  end
  def self.tableize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE)
    str = String.from_ruby(rb_str)
    Inflector.tableize(str).to_ruby
  end
  def self.classify(self : LibRuby::VALUE, rb_str : LibRuby::VALUE)
    str = String.from_ruby(rb_str)
    Inflector.classify(str).to_ruby
  end
  def self.humanize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE, capitalize : LibRuby::VALUE)
    capitalize = Bool.from_ruby(capitalize)
    str = String.from_ruby(rb_str)
    Inflector.humanize(str, capitalize).to_ruby
  end
  def self.upcase_first(self : LibRuby::VALUE, rb_str : LibRuby::VALUE)
    str = String.from_ruby(rb_str)
    Inflector.upcase_first(str).to_ruby
  end
  def self.foreign_key(self : LibRuby::VALUE, rb_str : LibRuby::VALUE, separate_class_name_and_id_with_underscore : LibRuby::VALUE)
    sep = Bool.from_ruby(separate_class_name_and_id_with_underscore)
    str = String.from_ruby(rb_str)
    Inflector.foreign_key(str, sep).to_ruby
  end
  def self.ordinal(self : LibRuby::VALUE, rb_int : LibRuby::VALUE)
    int = Int.from_ruby(rb_int)
    Inflector.ordinal(int).to_ruby
  end
  def self.ordinalize(self : LibRuby::VALUE, rb_int : LibRuby::VALUE)
    int = Int.from_ruby(rb_int)
    Inflector.ordinalize(int).to_ruby
  end
end
