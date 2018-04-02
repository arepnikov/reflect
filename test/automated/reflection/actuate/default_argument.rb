require_relative '../../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Actuate" do
      context "Default Argument" do
        subject = Reflect::Controls::Subject.example

        reflection = Reflect.(subject, :SomeConstant, strict: true)

        result = reflection.(:some_method)

        test "Method is called with the subject as the argument" do
          assert(result == subject)
        end
      end
    end
  end
end
