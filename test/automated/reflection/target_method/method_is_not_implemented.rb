require_relative '../../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Target Method" do
      context "Method Is Not Implemented" do
        subject = Controls::Subject.example
        reflection = Reflect.(subject, :SomeConstant)

        method_name = :not_implemented_method

        test "Is an error" do
          assert_raises(Reflect::Error) do
            reflection.target_method(method_name)
          end
        end
      end
    end
  end
end
