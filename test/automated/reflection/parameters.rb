require_relative '../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Parameters" do
      constant_name = :SomeConstant
      method_name = :some_method

      subject = Reflect::Controls::Subject::MixedParameters::Example.new

      target = Reflect::Controls::Subject::MixedParameters::Example::SomeConstant
      target_method_parameters = target.method(method_name).parameters

      reflection  = Reflect.(subject, constant_name, strict: true)
      parameters = reflection.parameters(method_name)

      test "Target method's parameters" do
        assert(parameters == target_method_parameters)
      end
    end
  end
end
