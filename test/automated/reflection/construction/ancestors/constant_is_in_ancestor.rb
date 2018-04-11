require_relative '../../../automated_init'

context "Reflection" do
  context "Construction" do
    context "Constant Is in an Ancestor" do
      subject = Reflect::Controls::Ancestor::Example::Descendant.new

      reflection = Reflect.(subject, :SomeConstant, ancestors: true)

      test "Constant is the subject's super class inner namespace that corresponds to the constant name" do
        assert(reflection.constant == Reflect::Controls::Ancestor::Example::SomeConstant)
      end
    end
  end
end
