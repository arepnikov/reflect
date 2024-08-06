require_relative '../../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Arity" do
      constant_name = :SomeConstant
      method_name = :some_method

      subject = Reflect::Controls::Subject::Example.new

      target = Reflect::Controls::Subject::Example::SomeConstant
      target_method_arity = target.method(method_name).arity

      reflection = Reflect.(subject, constant_name, strict: true)
      arity = reflection.arity(method_name)

      test "Target method's arity" do
        assert(arity == target_method_arity)
      end
    end
  end
end
