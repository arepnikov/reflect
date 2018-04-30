require_relative '../../../../automated_init'

context "Reflection" do
  context "Inner Reflection" do
    context "Get" do
      context "Accessor Returns an Object" do
        context "Do Not Coerce Object to Constant" do
          subject = Reflect::Controls::Subject.example

          reflection = Reflect.(subject, :SomeConstant)

          inner_reflection = reflection.get(:some_object_accessor, coerce_constant: false)

          context "Inner Reflection" do
            test "Target is the object" do
              assert(inner_reflection.target.instance_of?(Reflect::Controls::Subject::Example::SomeConstant::SomeInnerClass))
            end
          end
        end
      end
    end
  end
end
