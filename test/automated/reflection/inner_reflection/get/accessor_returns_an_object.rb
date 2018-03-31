require_relative '../../../automated_init'

context "Reflection" do
  context "Inner Reflection" do
    context "Get" do
      context "Accessor Returns an Object" do
        subject = Reflect::Controls::Subject.example

        reflection = Reflect.(subject, :SomeConstant)

        inner_reflection = reflection.get(:some_object_accessor)

        context "Inner Reflection" do
          test "Constant is the object's constant" do
            assert(inner_reflection.constant == Reflect::Controls::Subject::Example::SomeConstant::SomeInnerClass)
          end
        end
      end
    end
  end
end
