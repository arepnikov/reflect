require_relative '../../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Actuator" do
      subject = Reflect::Controls::Subject::Example.new
      target = Reflect::Controls::Subject::Example::SomeConstant

      constant_name = :SomeConstant
      method_name = :some_method

      RecordInvocation.(target, method_name)

      reflection = Reflect.(subject, constant_name, strict: true)
      reflection.(method_name, subject, :some_arg)

      invocations = target.invocations(method_name)
      invocation = invocations.last

      context "Target's #{method_name} Method" do
        test! "Invoked" do
          refute(invocation.nil?)
        end

        context "Arguments" do
          arguments = invocation.arguments

          context "First Positional" do
            value = arguments[:some_parameter]

            test "Value" do
              assert(value == subject)
            end
          end

          context "Other Positional" do
            value = arguments[:some_other_parameter]

            test "Value" do
              assert(value == :some_arg)
            end
          end
        end
      end
    end
  end
end
