require_relative '../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Arity" do
      constant_name = :SomeConstant
      subject = Controls::Subject.example
      target = Controls::Target.example(constant_name:, subject:)

      method_name = :some_method
      target_method_arity = target.method(method_name).arity

      reflection = Reflect.(subject, constant_name)
      arity = reflection.arity(method_name)

      test "Target method's arity" do
        assert(arity == target_method_arity)
      end
    end
  end
end
