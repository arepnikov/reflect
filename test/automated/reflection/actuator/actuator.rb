require_relative '../../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Actuator" do
      constant_name = Controls::Namespace::Random.get
      subject = Controls::Subject.example
      target = Controls::Target.example(constant_name:, subject:)

      method_name = :some_method
      RecordInvocation.(target, method_name)

      reflection = Reflect.(subject, constant_name, strict: true)
      reflection.(method_name, subject, :some_arg)

      invocation = target.invocation(method_name)

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
