require_relative '../../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Target Method" do
      constant_name = :SomeConstant
      subject = Controls::Subject.example
      target = Controls::Target.example(constant_name:, subject:)

      method_name = :some_method
      target_method = target.method(method_name)

      reflection = Reflect.(subject, constant_name)
      reflection_target_method = reflection.target_method(method_name)

      test do
        assert(target_method == reflection_target_method)
      end
    end
  end
end
