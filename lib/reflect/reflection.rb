module Reflect
  class Reflection
    attr_reader :subject
    attr_reader :target
    alias :constant :target
    attr_reader :strict

    def subject_constant
      @subject_constant ||= Reflect.constant(subject)
    end

    def initialize(subject, target, strict)
      @subject = subject
      @target = target
      @strict = strict
    end

    def self.build(subject, constant_name, strict: nil, ancestors: nil)
      strict = Default.strict if strict.nil?
      ancestors = Default.ancestors if ancestors.nil?

      subject_constant = Reflect.constant(subject)

      target = Reflect.get_constant(subject_constant, constant_name, strict: strict, ancestors: ancestors)
      return nil if target.nil?

      new(subject, target, strict)
    end

    def call(method_name, ...)
      target_method = target_method(method_name)
      target_method.(...)
    end

    def !(method_name, ...)
      call(method_name, subject, ...)
    end

    def target_method?(method_name, subject=nil)
      subject ||= target
      subject.respond_to?(method_name)
    end

    def target_accessor?(method_name, subject=nil)
      target_method?(method_name, subject)
    end

    def target_method(method_name)
      if !target_method?(method_name)
        target_name = Reflect.constant(target).name
        raise Reflect::Error, "#{target_name} does not define method #{method_name}"
      end

      target.public_method(method_name)
    end

    def arity(method_name)
      target_method = target_method(method_name)
      target_method.arity
    end

    def parameters(method_name)
      target_method = target_method(method_name)
      target_method.parameters
    end

    def get(accessor_name, strict: nil, coerce_constant: nil)
      strict = self.strict if strict.nil?
      coerce_constant = true if coerce_constant.nil?

      target = get_target(accessor_name, strict: strict)
      return nil if target.nil?

      if coerce_constant
        target = Reflect.constant(target)
      end

      self.class.new(subject, target, strict)
    end

    def get_target(accessor_name, strict: nil)
      strict = self.strict if strict.nil?

      if !target_accessor?(accessor_name)
        if strict
          target_name = Reflect.constant(target).name
          raise Reflect::Error, "#{target_name} does not have accessor #{accessor_name}"
        else
          return nil
        end
      end

      target.public_send(accessor_name)
    end

    module Default
      def self.strict
        true
      end

      def self.ancestors
        false
      end
    end
  end
end
