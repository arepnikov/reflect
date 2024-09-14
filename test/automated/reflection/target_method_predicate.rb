require_relative '../automated_init'

context "Reflect" do
  context "Reflection" do
    context "Target Method Predicate" do
      subject = Controls::Subject.example
      reflection = Reflect.(subject, :SomeConstant)

      context "Method Implemented" do
        method_name = :some_method
        method_implemented = reflection.target_method?(method_name)

        test do
          assert(method_implemented)
        end
      end

      context "Method Is Not Implemented" do
        method_name = :not_implemented_method
        method_implemented = reflection.target_method?(method_name)

        test do
          refute(method_implemented)
        end
      end
    end
  end
end
