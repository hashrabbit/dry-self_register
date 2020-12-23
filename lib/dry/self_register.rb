require 'dry/container'

require 'dry/self_register/version'
require 'dry/self_register/builder'

module Dry
  module SelfRegister
    class Error < StandardError; end
  end

  def self.SelfRegister(container)
    SelfRegister::Builder.new(container)
  end
end
