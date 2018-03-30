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

          def some_method(param)
          end

          module SomeInnerConstant
            def some_implementation_method(param, other_param)
            end
          end
        end

        module SomeOtherConstant
        end
      end
    end
  end
end
