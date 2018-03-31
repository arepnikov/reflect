require_relative '../../../automated_init'

context "Reflection" do
  context "Construction" do
    context "Inner Constant Is not Defined" do
      context "Strict" do
        subject = Reflect::Controls::Subject.example

        random_constant_name = Reflect::Controls::Namespace::Random.get

        test "Is an error" do
          assert proc { Reflect.(subject, random_constant_name, strict: true) } do
            raises_error? Reflect::Error
          end
        end
      end
    end
  end
end
