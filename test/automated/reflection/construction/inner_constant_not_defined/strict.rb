require_relative '../../../automated_init'

context "Reflection" do
  context "Construction" do
    context "Inner Constant Is not Defined" do
      context "Strict" do
        subject = Reflect::Controls::Subject.example

        random_constant_name = Reflect::Controls::Namespace::Random.get

        test "Is an error" do
          assert_raises(Reflect::Error) do
            Reflect.(subject, random_constant_name, strict: true)
          end
        end
      end
    end
  end
end
