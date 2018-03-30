require_relative './automated_init'

context "Reflect" do
  context "Reflection" do
    subject = Reflect::Controls::Subject.example

    reflection = Reflect.(subject, :SomeConstant)

    test "Subject is the given subject" do
      assert(reflection.subject == subject)
    end

    test "Subject constant is the subject's constant" do
      assert(reflection.subject_constant == subject.class)
    end

    test "Constant is the subject's inner namespace that corresponds to the constant name" do
      assert(reflection.constant == Reflect::Controls::Subject::Example::SomeConstant)
    end
  end
end
