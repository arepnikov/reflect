require_relative '../../../automated_init'

context "Reflection" do
  context "Inner Reflection" do
    context "Constant Accessor Is not Defined" do
      context "Strict" do
        subject = Reflect::Controls::Subject.example

        reflection = Reflect.(subject, :SomeConstant, strict: true)

        random_accessor_name = Reflect::Controls::Namespace::Random.get

        test "Is an error" do
          assert proc { reflection.get(random_accessor_name) } do
            raises_error? Reflect::Error
          end
        end
      end
    end
  end
end
