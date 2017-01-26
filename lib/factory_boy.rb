require "factory_boy/version"
require "factory_boy/factory"

module FactoryBoy
  class << self
    @@defined_classes = {}

    def define_factory(klass, &block)
      if block_given?
        @@defined_classes[klass.name] = Factory.new(klass, &block)
      else
        @@defined_classes[klass.name] = Factory.new(klass)
      end
    end

    def build(klass, attributes = {})
      raise Exception unless instance = @@defined_classes[klass.name].klass
      attributes.each{|key, value|
        instance.send("#{key}=", value) if instance.respond_to? "#{key}="
      }
    instance
    end
  end
end
