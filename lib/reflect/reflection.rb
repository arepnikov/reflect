module Reflect
  class Reflection
    attr_reader :subject
    attr_reader :subject_constant
    attr_reader :constant

    def initialize(subject, subject_constant, constant)
      @subject = subject
      @subject_constant = subject_constant
      @constant = constant
    end

    def self.call(subject, constant_name, strict: nil)
      build(subject, constant_name, strict: strict)
    end

    def self.build(subject, constant_name, strict: nil)
      subject_constant = Reflect.subject_constant(subject)
      constant = Reflect.get_constant(subject_constant, constant_name, strict: strict)
      instance = new(subject, subject_constant, constant)
    end

    def constant_accessor?(name)
      constant.respond_to?(name)
    end

    def access_constant(accessor_name)
      constant.send(accessor_name)
    end
  end
end
