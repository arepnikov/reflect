require_relative '../../../automated_init'

context "Reflection" do
  context "Inner Reflection" do
    context "Get" do
      subject = Reflect::Controls::Subject.example

      reflection = Reflect.(subject, :SomeConstant)

      inner_reflection = reflection.get(:some_accessor)

      context "Inner Reflection" do
        test "Subject is the source reflection's subject" do
          assert(inner_reflection.subject == subject)
        end

        test "Subject constant is the subject's constant" do
          assert(inner_reflection.subject_constant == subject.class)
        end

        test "Constant is the subject's inner namespace that corresponds to the constant name" do
          assert(inner_reflection.constant == Reflect::Controls::Subject::Example::SomeConstant::SomeInnerConstant)
        end
      end
    end
  end
end
