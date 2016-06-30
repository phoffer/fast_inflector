require "crystalized_ruby/lib_ruby"
require "./wrapper"

fun init = Init_fast_inflector
  GC.init
  LibCrystalMain.__crystal_main(0, Pointer(Pointer(UInt8)).null)

  geode = LibRuby.rb_define_module("Geode", LibRuby.rb_cObject)
  inflector = LibRuby.rb_define_module_under(geode, "FastInflector", LibRuby.rb_cObject)

  LibRuby2.rb_define_module_function(inflector, "acronym",      ->Wrapper.acronym,        2)
  LibRuby3.rb_define_module_function(inflector, "plural",       ->Wrapper.plural,         3)
  LibRuby3.rb_define_module_function(inflector, "singular",     ->Wrapper.singular,       3)
  LibRuby3.rb_define_module_function(inflector, "human",        ->Wrapper.human,          3)
  LibRuby3.rb_define_module_function(inflector, "irregular",    ->Wrapper.irregular,      3)
  LibRuby2.rb_define_module_function(inflector, "uncountable",  ->Wrapper.uncountable,    2)
  LibRuby2.rb_define_module_function(inflector, "clear",        ->Wrapper.clear,          2)
  LibRuby1.rb_define_module_function(inflector, "uncountables", ->Wrapper.uncountables,   1)
  LibRuby1.rb_define_module_function(inflector, "plurals",      ->Wrapper.plurals,        1)
  LibRuby1.rb_define_module_function(inflector, "singulars",    ->Wrapper.singulars,      1)
  LibRuby1.rb_define_module_function(inflector, "humans",       ->Wrapper.humans,         1)
  LibRuby1.rb_define_module_function(inflector, "acronyms",     ->Wrapper.acronyms,       1)


  LibRuby2.rb_define_module_function(inflector, "pluralize",     ->Wrapper.pluralize,     2)
  LibRuby2.rb_define_module_function(inflector, "singularize",   ->Wrapper.singularize,   2)
  LibRuby2.rb_define_module_function(inflector, "camelize",      ->Wrapper.camelize,      2)
  LibRuby1.rb_define_module_function(inflector, "titleize",      ->Wrapper.titleize,      1)
  LibRuby1.rb_define_module_function(inflector, "underscore",    ->Wrapper.underscore,    1)
  LibRuby1.rb_define_module_function(inflector, "dasherize",     ->Wrapper.dasherize,     1)
  LibRuby1.rb_define_module_function(inflector, "demodulize",    ->Wrapper.demodulize,    1)
  LibRuby1.rb_define_module_function(inflector, "deconstantize", ->Wrapper.deconstantize, 1)
  LibRuby1.rb_define_module_function(inflector, "tableize",      ->Wrapper.tableize,      1)
  LibRuby1.rb_define_module_function(inflector, "classify",      ->Wrapper.classify,      1)
  LibRuby2.rb_define_module_function(inflector, "humanize",      ->Wrapper.humanize,      2)
  LibRuby1.rb_define_module_function(inflector, "upcase_first",  ->Wrapper.upcase_first,  1)
  LibRuby2.rb_define_module_function(inflector, "foreign_key",   ->Wrapper.foreign_key,   2)
  LibRuby1.rb_define_module_function(inflector, "ordinal",       ->Wrapper.ordinal,       1)
  LibRuby1.rb_define_module_function(inflector, "ordinalize",    ->Wrapper.ordinalize,    1)

end
