module FactoryBoy
  class Factory
    attr_accessor :klass, :block, :instance
    class TestClass; attr_accessor :name, :id; end
    def initialize(klass, &block)
      @klass = klass.is_a?(Symbol) ? Object.const_get(klass.to_s.split('_').collect(&:capitalize).join) : klass
      @block = block if block_given?
    end

    def build(attributes)
      @instance = @klass.new
      instance_eval(&block) if block
      attributes.each{|key, value|
        @instance.send("#{key}=", value) if @instance.respond_to? "#{key}="
      }
      @instance
    end

    def key
      @klass.name
    end

    def method_missing(m, *args, &block)
      set_attribute m, *args, &block
    end

    private

    def set_attribute m, *args, &block
      @instance.send("#{m}=", args[0]) if @instance.respond_to? "#{m}="
    end
  end
end