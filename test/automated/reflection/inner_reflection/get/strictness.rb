require_relative '../../../automated_init'

context "Reflection" do
  context "Inner Reflection" do
    context "Get" do
      context "Strictness" do
        subject = Reflect::Controls::Subject.example

        reflection = Reflect.(subject, :SomeConstant)

        [false, true].each do |strict|
          context "#{strict}" do

            inner_reflection = reflection.get(:some_accessor, strict: strict)

            context "Inner Reflection" do
              test "Strict is #{strict}" do
                assert(inner_reflection.strict == strict)
              end
            end
          end
        end
      end
    end
  end
end
