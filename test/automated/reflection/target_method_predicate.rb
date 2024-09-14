require_relative '../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Target Method Predicate" do
      context "Method Implemented" do
        subject = Reflect::Controls::Subject.example
        reflection = Reflect.(subject, :SomeConstant)

        method_name = :some_method
        method_implemented = reflection.target_method?(method_name)

        test do
          assert(method_implemented)
        end
      end

      context "Method Is Not Implemented" do
        subject = Reflect::Controls::Subject.example
        reflection = Reflect.(subject, :SomeConstant)

        random_method_name = Reflect::Controls::Namespace::Random.get
        method_implemented = reflection.target_method?(random_method_name)

        test do
          refute(method_implemented)
        end
      end
    end
  end
end
