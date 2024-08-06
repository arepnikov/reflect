require_relative '../../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Arity" do
      context "Method Is Not Implemented" do
        subject = Reflect::Controls::Subject.example

        reflection = Reflect.(subject, :SomeConstant, strict: true)

        random_method_name = Reflect::Controls::Namespace::Random.get

        test "Is an error" do
          assert_raises(Reflect::Error) do
            reflection.arity(random_method_name)
          end
        end
      end
    end
  end
end
