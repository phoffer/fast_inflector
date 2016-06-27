require "inflector"
module Wrapper

  def self.squish(self : LibRuby::VALUE, rb_str)
    str = String.from_ruby(rb_str)
    str.to_ruby
  end
  def self.pluralize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE, locale : LibRuby::VALUE)
    locale = :en
    str = String.from_ruby(rb_str)
    Inflector.pluralize(str, locale).to_ruby
  end
  def self.singularize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE, locale : LibRuby::VALUE)
    locale = :en
    str = String.from_ruby(rb_str)
    Inflector.singularize(str, locale).to_ruby
  end
  def self.camelize(self : LibRuby::VALUE, rb_str : LibRuby::VALUE, first_letter : LibRuby::VALUE)
    first_letter = :upper
    str = String.from_ruby(rb_str)
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
    capitalize = true
    str = String.from_ruby(rb_str)
    Inflector.humanize(str, capitalize).to_ruby
  end
  def self.upcase_first(self : LibRuby::VALUE, rb_str : LibRuby::VALUE)
    str = String.from_ruby(rb_str)
    Inflector.upcase_first(str).to_ruby
  end
  def self.foreign_key(self : LibRuby::VALUE, rb_str : LibRuby::VALUE, separate_class_name_and_id_with_underscore : LibRuby::VALUE)
    separate_class_name_and_id_with_underscore = true
    str = String.from_ruby(rb_str)
    Inflector.foreign_key(str, separate_class_name_and_id_with_underscore).to_ruby
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
