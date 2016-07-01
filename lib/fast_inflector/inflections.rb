module ActiveSupport
  module Inflector
    class Inflections
      @@__instance__ = {}
      def initialize(locale = :en)
        @locale = locale
      end
      def acronym(word)
        Geode::FastInflector.acronym(@locale, word)
      end
      def plural(word, replacement)
        Geode::FastInflector.plural(@locale, word, replacement)
      end
      def singular(word, replacement)
        Geode::FastInflector.singular(@locale, word, replacement)
      end
      def human(word, replacement)
        Geode::FastInflector.human(@locale, word, replacement)
      end
      def irregular(word, replacement)
        Geode::FastInflector.irregular(@locale, word, replacement)
      end
      # def uncountable(*words)
      #   words = words.flatten.compact
      #   if words.empty?
      #     Geode::FastInflector.uncountables(@locale)
      #   else
      #     puts words.inspect
      #     Geode::FastInflector.uncountable_words(@locale, words.map(&:downcase))
      #   end
      # end
      def uncountable(*words)
        # puts words.flatten.compact.inspect
        words.flatten.compact.each do |word|
          Geode::FastInflector.uncountable(@locale, word)
        end
        Geode::FastInflector.uncountables(@locale)
      end
      # def uncountable(word)
      #   Geode::FastInflector.uncountable(@locale, word)
      # end
      def uncountables
        Geode::FastInflector.uncountables(@locale)
      end
      def plurals
        Geode::FastInflector.plurals(@locale)
      end
      def singulars
        Geode::FastInflector.singulars(@locale)
      end
      def humans
        Geode::FastInflector.humans(@locale)
      end
      def acronyms
        Geode::FastInflector.acronyms(@locale)
      end
      def clear(scope = :all)
        Geode::FastInflector.clear(@locale, scope.to_s)
      end
      # def inflector
        
      # end
      def self.instance(locale = :en)
        @@__instance__[locale] ||= new(locale)
      end
    end

    # Yields a singleton instance of Inflector::Inflections so you can specify
    # additional inflector rules. If passed an optional locale, rules for other
    # languages can be specified. If not specified, defaults to <tt>:en</tt>.
    # Only rules for English are provided.
    #
    #   ActiveSupport::Inflector.inflections(:en) do |inflect|
    #     inflect.uncountable "rails"
    #   end
    # def inflections(locale : Symbol = :en, &block)
    #   yield Inflections.instance(locale)
    # end
    # def inflections(locale : Symbol = :en)
    #   Inflections.instance(locale)
    # end
    def self.inflections(locale = :en)
      if block_given?
        yield Inflections.instance(locale)
      else
        Inflections.instance(locale)
      end
    end
  end
end
