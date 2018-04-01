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

          module SomeInnerConstant
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
