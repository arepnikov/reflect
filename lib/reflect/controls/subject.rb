module Reflect
  module Controls
    module Subject
      def self.example
        Example.new
      end

      class Example
        module SomeConstant
          extend Target::Methods
        end

        module ConstantWithoutAccessor
        end
      end

      module MixedParameters
        def self.example
          Example.new
        end

        class Example
          module SomeConstant
            def self.some_method(
              some_parameter,
              some_optional_parameter=nil,
              *some_multiple_assignment_parameter,
              some_keyword_parameter:,
              some_optional_keyword_parameter: nil,
              **some_multiple_assignment_keyword_parameter,
              &some_block
            )
            end
          end
        end
      end
    end
  end
end
