require_relative '../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Parameters" do
      constant_name = Controls::Namespace::Random.get
      subject = Controls::Subject.example
      target = Controls::Target::MixedParameters.example(constant_name:, subject:)

      method_name = :some_method
      target_method_parameters = target.method(method_name).parameters

      reflection = Reflect.(subject, constant_name, strict: true)
      parameters = reflection.parameters(method_name)

      test "Target method's parameters" do
        assert(parameters == target_method_parameters)
      end
    end
  end
end
