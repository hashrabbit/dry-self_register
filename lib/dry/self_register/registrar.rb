module Dry
  module SelfRegister
    class Registrar < Module
      def initialize(container, with_new:)
        @container = container
        @with_new = with_new
        super()
      end

      def included(klass)
        name = underscore(klass.to_s)
        @container.register(name, @with_new ? -> { klass.send(:new) } : klass)
      end

      private

      # A simplified version of #underscore, from active_support/inflector.rb
      def underscore(klass)
        return klass unless /::/.match?(klass)

        word = klass.to_s.gsub('::'.freeze, '.'.freeze)
        word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2'.freeze)
        word.gsub!(/([a-z\d])([A-Z])/, '\1_\2'.freeze)
        word.downcase!
        word
      end
    end
  end
end
