require 'dry/self_register/registrar'

module Dry
  module SelfRegister
    class Builder < Module
      attr_reader :container, :registrar

      def initialize(container, registrar = Registrar)
        @container = container
        @registrar = registrar
        super()
      end

      def included(klass)
        klass.include(self[:new])
      end

      def [](style)
        unless [:new, :class].include?(style)
          raise 'Dry::SelfRegister supports only :new and :class styles'
        end

        registrar.new(container, with_new: style == :new)
      end
    end
  end
end
