require "factory_boy/version"

module FactoryBoy
  class << self
    @@defined_classes = []

    def define_factory(klass)
      @@defined_classes << klass
    end

    def build(klass, attributes = {})
      if @@defined_classes.any?{|c| c == klass}
        instance = klass.new
        attributes.each{|key, value|
          if instance.respond_to? "#{key}="
            instance.send "#{key}=", value
          end
        }
        instance
      else
        raise Exception
      end
    end
  end
end
