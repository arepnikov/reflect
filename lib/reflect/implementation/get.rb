module Protocol
  module Implementation
    module Get
      extend self

      def self.call(protocol_namespace, implementation_name, strict: nil)
        strict = true if strict.nil?

        accessor_implemented = implementation_accessor?(protocol_namespace, implementation_name)

        if !accessor_implemented && strict
          raise Protocol::Error, "Implementation #{implementation_name} is not in protocol namespace #{protocol_namespace.name}"
        end

        implementation = nil
        if accessor_implemented
          implementation = get_implementation(protocol_namespace, implementation_name)
        end

        implementation
      end

      def get_implementation(protocol_namespace, implementation_name)
        protocol_namespace.send(implementation_name)
      end

      def implementation_accessor?(protocol_namespace, implementation_name)
        protocol_namespace.respond_to?(implementation_name)
      end
    end
  end
end
