require 'spec_helper'
require 'pry'

describe FactoryBoy do
  class TestClass; attr_accessor :name; end

  it 'has a version number' do
    expect(FactoryBoy::VERSION).not_to be nil
  end

  describe '#define_factory' do
    it 'allows to define fatory for new class' do
      expect{FactoryBoy.define_factory(TestClass)}.not_to raise_error
    end
  end

  describe '#build' do
    # We need second classes as defined class is singleton
    it 'raises error if class is not defined' do
      expect{FactoryBoy.build(Class)}.to raise_error(Exception)
    end

    context 'TestClass is defined' do
      before do
        FactoryBoy.define_factory TestClass
      end

      it 'returns new class instance' do
        expect(FactoryBoy.build(TestClass)).to be_instance_of(TestClass)
      end

      it 'allows to set params to the class' do
        expect(FactoryBoy.build(TestClass, name: 'Class')).to be_instance_of(TestClass)
      end

      it 'sets attribute if attribute exists' do
        expect(FactoryBoy.build(TestClass, name: 'Class').name).to eq('Class')
      end

      it 'doesn\'t raise an error if attribute does not exist' do
        expect{FactoryBoy.build(TestClass, test: 'Class')}.not_to raise_error(Exception)
      end
    end
  end
end
