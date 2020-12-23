require 'spec_helper'

module Dry
  module SelfRegister
    Example = Class.new

    RSpec.describe Registrar do
      let(:container) { Dry::Container.new }

      context 'when included in a class, with_new: true' do
        let(:registrar) { described_class.new(container, with_new: true) }

        it 'registers an instance of the class to the container' do
          Example.include(registrar)
          expect(container['dry.self_register.example']).to be_an_instance_of(Example)
        end
      end

      context 'when included in a class, with_new: false' do
        let(:registrar) { described_class.new(container, with_new: false) }

        it 'registers the class object to the container' do
          Example.include(registrar)
          expect(container['dry.self_register.example']).to eq(Example)
        end
      end
    end

    RSpec.describe Builder do
      let(:container) { Dry::Container.new }
      let(:builder) { described_class.new(container) }

      context 'when included with the [:class] style' do
        it 'causes the class to be registered to the container' do
          Example.include(builder[:class])
          expect(container['dry.self_register.example']).to eq(Example)
        end
      end

      context 'when included with an invalid style' do
        it 'raises an error' do
          expect { Example.include(builder[:foo]) }.to raise_error(RuntimeError)
        end
      end
    end
  end

  RSpec.describe 'Dry.SelfRegister()' do
    let(:container) { Dry::Container.new }

    it 'returns an instance of the Builder class' do
      expect(Dry.SelfRegister(container)).to be_instance_of(SelfRegister::Builder)
    end
  end
end
