require_relative '../../../automated_init'

context "Reflection" do
  context "Construction" do
    context "Inner Constant Is not Defined" do
      context "Not Strict" do
        subject = Reflect::Controls::Subject.example

        random_constant_name = Reflect::Controls::Namespace::Random.get

        reflection = Reflect.(subject, random_constant_name, strict: false)

        test "Reflection is nil" do
          assert(reflection.nil?)
        end
      end
    end
  end
end
