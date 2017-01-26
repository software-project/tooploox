require "factory_boy/version"
require "factory_boy/factory"

module FactoryBoy
  class << self
    @@defined_classes = {}

    def define_factory(klass, &block)
      if block_given?
        factory = Factory.new(klass, &block)
      else
        factory = Factory.new(klass)
      end
      @@defined_classes[factory.key] = factory
    end

    def build(klass, attributes = {})
      raise Exception unless instance = @@defined_classes[klass.name].build(attributes)
    instance
    end
  end
end
