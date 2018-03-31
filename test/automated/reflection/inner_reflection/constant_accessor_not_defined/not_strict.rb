require_relative '../../../automated_init'

context "Reflection" do
  context "Inner Reflection" do
    context "Constant Accessor Is not Defined" do
      context "Not Strict" do
        subject = Reflect::Controls::Subject.example

        reflection = Reflect.(subject, :SomeConstant, strict: false)

        random_accessor_name = Reflect::Controls::Namespace::Random.get

        inner_reflection = reflection.get(random_accessor_name)

        test "Inner reflection is nil" do
          assert(inner_reflection.nil?)
        end
      end
    end
  end
end
