module Reflect
  class Reflection
    attr_reader :subject
    attr_reader :target
    alias :constant :target
    attr_reader :strict

    def subject_constant
      @subject_constant ||= Reflect.subject_constant(subject)
    end

    def initialize(subject, target, strict)
      @subject = subject
      @target = target
      @strict = strict
    end

    def self.build(subject, constant_name, strict: nil, ancestors: nil)
      strict = Default.strict if strict.nil?
      ancestors = Default.ancestors if ancestors.nil?

      subject_constant = Reflect.subject_constant(subject)

      target = Reflect.get_constant(subject_constant, constant_name, strict: strict, ancestors: ancestors)
      return nil if target.nil?

      instance = new(subject, target, strict)
    end

    def call(method_name, arg=nil)
      unless constant.respond_to?(method_name)
        raise Reflect::Error, "Constant #{constant.name} does not define method #{method_name}"
      end

      arg ||= subject

      constant.send(method_name, arg)
    end

    def target_accessor?(name, subject=nil)
      subject ||= constant
      subject.respond_to?(name)
    end

##    def constant_accessor?(name)
##      constant.respond_to?(name)
##    end

    def get(accessor_name, strict: nil)
      strict = self.strict if strict.nil?

##
      result = access_target(accessor_name, strict: strict)
      return nil if result.nil?

      constant = Reflect.subject_constant(result)
      self.class.new(subject, constant, strict)
    end

## was get_constant
    def access_target(accessor_name, strict: nil)
      strict = self.strict if strict.nil?

##      if !constant_accessor?(accessor_name)
      if !target_accessor?(accessor_name)
        if strict
          raise Reflect::Error, "Constant #{constant.name} does not have accessor #{accessor_name}"
        else
          return nil
        end
      end

      constant.send(accessor_name)
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
