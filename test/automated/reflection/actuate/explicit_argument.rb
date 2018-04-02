require_relative '../../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Actuate" do
      context "Explicit Argument" do
        subject = Reflect::Controls::Subject.example

        reflection = Reflect.(subject, :SomeConstant, strict: true)

        random_data = Reflect::Controls::Namespace::Random.get

        result = reflection.(:some_method, random_data)

        test "Method is called with the explicit argument" do
          assert(result == random_data)
        end
      end
    end
  end
end
