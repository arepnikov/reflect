module Reflect
  module Controls
    module Subject
      def self.example
        Example.new
      end

      class Example
        module SomeConstant
          def self.some_accessor
            SomeInnerConstant
          end

          def self.some_object_accessor
            SomeInnerClass.new
          end

          def self.some_method(some_parameter, some_other_parameter)
          end

          module SomeInnerConstant
          end

          class SomeInnerClass
          end
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
