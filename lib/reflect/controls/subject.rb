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
    end
  end
end
