module Reflect
  def self.call(subject, constant_name, strict: nil)
    Reflection.build(subject, constant_name, strict: strict)
  end

  def self.subject_constant(subject)
    [Module, Class].include?(subject.class) ? subject : subject.class
  end

  def self.get_constant(subject_constant, constant_name, strict: nil)
    strict = true if strict.nil?

    constant = nil

    if constant?(subject_constant, constant_name)
      constant = get_constant!(subject_constant, constant_name)
    end

    # if constant.nil? && strict
    #   raise Protocol::Error, "Namespace #{namespace_names.join(', ')} is not in #{subject_constant.name}"
    # end

    constant
  end

  def self.get_constant!(subject_constant, constant_name)
    subject_constant.const_get(constant_name, false)
  end

  def self.constant?(subject_constant, constant_name)
    subject_constant.const_defined?(constant_name, false)
  end
end
