require_relative '../../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Construction" do
      context "Strict is the Default" do
        subject = Reflect::Controls::Subject.example

        reflection = Reflect.(subject, :SomeConstant)

        test "Strict is true" do
          assert(reflection.strict == true)
        end
      end
    end
  end
end
