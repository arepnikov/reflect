module Protocol
  Error = Class.new(RuntimeError)

  module Get
    extend self

    def self.call(subject, *namespace_names, implementation: nil, strict: nil)
      namespace_names = Array(namespace_names)
      strict = true if strict.nil?

      subject_const = subject_const(subject)

      protocol_namespace = protocol_namespace(subject_const, namespace_names, strict: strict)

      protocol_implementation = nil
      unless implementation.nil?
        protocol_implementation = Implementation::Get.(protocol_namespace, implementation, strict: strict)
      end

      if implementation
        return protocol_implementation
      else
        return protocol_namespace
      end
    end

    def subject_const(subject)
      [Module, Class].include?(subject.class) ? subject : subject.class
    end

    def protocol_namespace(subject_const, *namespace_names, strict: nil)
      namespace_names = Array(namespace_names).flatten
      strict = true if strict.nil?

      protocol_namespace = nil

      namespace_names.each do |namespace_name|
        protocol_namespace = get_protocol_namespace(subject_const, namespace_name)

        unless protocol_namespace.nil?
          break
        end
      end

      if protocol_namespace.nil? && strict
        raise Protocol::Error, "Namespace #{namespace_names.join(', ')} is not in #{subject_const.name}"
      end

      protocol_namespace
    end

    def get_protocol_namespace(subject_const, namespace_name)
      return nil unless protocol_namespace?(subject_const, namespace_name)
      subject_const.const_get(namespace_name, false)
    end

    def protocol_namespace?(subject_const, namespace_name)
      subject_const.const_defined?(namespace_name, false)
    end
  end
end
