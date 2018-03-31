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

          def some_method(param)
            true
          end

          module SomeInnerConstant
            def some_implementation_method(param, other_param)
            end
          end

          class SomeInnerClass
          end
        end

        module ConstantWithoutAccessor
        end
      end
    end
  end
end
