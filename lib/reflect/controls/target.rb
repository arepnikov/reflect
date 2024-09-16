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
        def self.extended(mod)
          mod.extend(SomeMethod)
          mod.extend(SomeAccessor)
          mod.extend(SomeObjectAccessor)
        end

        module SomeMethod
          def some_method(some_parameter, some_other_parameter)
          end
        end

        module SomeAccessor
          def self.extended(mod)
            constant = Module.new
            mod.const_set(:SomeInnerConstant, constant)
          end

          def some_accessor
            const_get(:SomeInnerConstant)
          end
        end

        module SomeObjectAccessor
          def self.extended(mod)
            cls = Class.new
            mod.const_set(:SomeInnerClass, cls)
          end

          def some_object_accessor
            cls = const_get(:SomeInnerClass)
            cls.new
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
