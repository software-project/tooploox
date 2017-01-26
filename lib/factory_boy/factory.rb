module FactoryBoy
  class Factory
    attr_accessor :klass, :block, :instance

    def initialize(klass, &block)
      @klass = klass
      @block = block if block_given?
    end

    def klass
      @instance = @klass.new
      instance_eval(&block) if block
      @instance
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