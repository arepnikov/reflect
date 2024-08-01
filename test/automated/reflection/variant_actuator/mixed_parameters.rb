require_relative '../../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Variant Actuator" do
      context "Mixed Parameters" do
        subject = Reflect::Controls::Subject::MixedParameters::Example.new
        target = Reflect::Controls::Subject::MixedParameters::Example::SomeConstant

        constant_name = :SomeConstant
        method_name = :some_method

        RecordInvocation.(target, method_name)

        control_block = proc { nil }

        reflection = Reflect.(subject, constant_name, strict: true)
        reflection.!(
          method_name,
          :some_optional_arg,
          :some_multiple_assignment_arg,
          :some_other_multiple_assignment_arg,
          some_keyword_parameter: :some_keyword_arg,
          some_optional_keyword_parameter: :some_optional_keyword_arg,
          some_multiple_assignment_keyword_parameter: :some_multiple_assignment_keyword_arg,
          some_other_multiple_assignment_keyword_parameter: :some_other_multiple_assignment_keyword_arg,
          &control_block
        )

        invocation = target.invocation(method_name)

        context "Target's #{method_name} Method" do
          test! "Invoked" do
            refute(invocation.nil?)
          end

          context "Arguments" do
            arguments = invocation.arguments

            context "Positional" do
              value = arguments[:some_parameter]

              test "Value is a subject" do
                assert(value == subject)
              end
            end

            context "Optional Positional" do
              value = arguments[:some_optional_parameter]

              test "Value" do
                assert(value == :some_optional_arg)
              end
            end

            context "Multiple Assignment" do
              value = invocation.arguments[:some_multiple_assignment_parameter]

              test "Value" do
                assert(value == [:some_multiple_assignment_arg, :some_other_multiple_assignment_arg])
              end
            end

            context "Keyword" do
              value = invocation.arguments[:some_keyword_parameter]

              test "Value" do
                assert(value == :some_keyword_arg)
              end
            end

            context "Optional Keyword" do
              value = invocation.arguments[:some_optional_keyword_parameter]

              test "Value" do
                assert(value == :some_optional_keyword_arg)
              end
            end

            context "Multiple Assignment Keyword Parameters" do
              value = invocation.arguments[:some_multiple_assignment_keyword_parameter]

              test "Value" do
                assert(value == {
                  some_multiple_assignment_keyword_parameter: :some_multiple_assignment_keyword_arg,
                  some_other_multiple_assignment_keyword_parameter: :some_other_multiple_assignment_keyword_arg
                 })
              end
            end

            context "Block" do
              value = invocation.arguments[:some_block]

              test "Value" do
                assert(value == control_block)
              end
            end
          end
        end
      end
    end
  end
end
