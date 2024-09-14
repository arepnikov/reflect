module Reflect
  module Controls
    module Target
      def self.example(constant_name: nil, subject: nil)
        constant_name ||= Namespace::Random.get
        subject ||= Subject.example

        target =
          Module.new do
            extend Methods
          end

        subject_constant = Reflect.constant(subject)
        subject_constant.const_set(constant_name, target)

        target
      end

      module Methods
        def self.extended(cls)
          cls.extend(SomeMethod)
          cls.extend(SomeAccessor)
          cls.extend(SomeObjectAccessor)
        end

        module SomeMethod
          def some_method(some_parameter, some_other_parameter)
          end
        end

        module SomeAccessor
          def self.extended(cls)
            some_inner_module = Module.new
            cls.const_set(:SomeInnerConstant, some_inner_module)
          end

          def some_accessor
            some_inner_module = const_get(:SomeInnerConstant)
            some_inner_module
          end
        end

        module SomeObjectAccessor
          def self.extended(cls)
            some_inner_class = Class.new
            cls.const_set(:SomeInnerClass, some_inner_class)
          end

          def some_object_accessor
            some_inner_class = const_get(:SomeInnerClass)
            some_inner_class.new
          end
        end
      end

      module MixedParameters
        def self.example(constant_name: nil, subject: nil)
          constant_name ||= Namespace::Random.get
          subject ||= Subject.example

          target =
            Module.new do
              extend Methods
            end

          subject_constant = Reflect.constant(subject)
          subject_constant.const_set(constant_name, target)

          target
        end

        module Methods
          def self.extended(cls)
            cls.extend(SomeMethod)
            cls.extend(Target::Methods::SomeAccessor)
            cls.extend(Target::Methods::SomeObjectAccessor)
          end

          module SomeMethod
            def some_method(
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
