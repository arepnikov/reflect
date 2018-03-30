require_relative '../../../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Inner Constant" do
      context "Accessor" do
        context "Constant Has Constant Accessor" do
          subject = Reflect::Controls::Subject.example

          reflection = Reflect.(subject, :SomeConstant)

          context "Detection" do
            test "Detected" do
              assert(reflection.constant_accessor?(:some_accessor))
            end
          end

          context "Invocation" do
            constant = reflection.access_constant(:some_accessor)

            test "Accessor gets the inner constant" do
              assert(constant == Reflect::Controls::Subject::Example::SomeConstant::SomeInnerConstant)
            end
          end
        end
      end
    end
  end
end
