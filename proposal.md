# Reflect Library Improvements Proposal

## Background

In Eventide's libraries, Reflect has 6 use cases, but 4 of them do not utilize it in the designed way. Instead of making a use of the reflection's actuator, the constant is pulled from the reflection.

The actuator is designed to pass the subject into the method being invoked. The subject can also be overridden, but either way, exactly one argument is always supplied to the protocol method:

```ruby
class SomeThing
  module Validate
    def self.call(some_thing)
      # validate some_thing
    end
  end
end

some_thing = SomeThing.new

validator_reflection = Reflect.(some_thing, :Validate)

validator_reflection.(:call) # validates some_thing

some_other_thing = SomeThing.new
validator_reflection.(:call, some_other_thing) # validates some_other_thing
```

However, the actuator doesn't support methods with zero arity or methods with arity greater than one. Due to this limitation, the constant is often pulled from the reflection, bypassing the actuator.

If the reflection's actuator were to support invoking protocol methods with any arity, then most use cases of the reflect library would be able to use the actuator and avoid disencapsulating the reflection's target constant.

## Reflection's Actuator

### Example: Method Without Arguments

#### Current Way Around

```ruby
class SomeClass
  module Substitute
    def self.build
      # build the substitute
    end
  end
end

some_instance = SomeClass.new
some_reflection = Reflect.(some_instance, :Substitute)

constant = some_reflection.constant
constant.build
# => some substitute
```

#### Proposed Change

```ruby
class SomeClass
  module Substitute
    def self.build
      # build the substitute
    end
  end
end

some_instance = SomeClass.new
some_reflection = Reflect.(some_instance, :Substitute)

some_reflection.(:build)
# => some substitute
```

### Example: Method With More Than One Argument

#### Current Way Around

```ruby
class SomeThing
  module Validate
    def self.call(some_thing, state)
      # validate some_thing
    end
  end
end

some_thing = SomeThing.new
validator_reflection = Reflect.(some_thing, :Validate)

validator = validator_reflection.constant
validator.call(some_thing, :some_state)
# => validate some_thing
```

#### Proposed Change

```ruby
class SomeThing
  module Validate
    def self.call(some_thing, state)
      # validate some_thing
    end
  end
end

some_thing = SomeThing.new
validator_reflection = Reflect.(some_thing, :Validate)

validator_reflection.(:call, some_thing, :some_state)
# => validate some_thing
```

## Reflection's Variant Actuator

Support for methods with any parameter signature is proposed. This necessitates a way to invoke the reflection's actuator so that it supplies the reflection's subject into the protocol method.

To address this, the introduction of a variant actuator method `.!()` is proposed. The variant actuator will pass the subject into the invoked method as the first positional argument, but will otherwise behave the same as the primary actuator:

```ruby
class SomeThing
  module Validate
    def self.call(some_thing, state)
      # validate some_thing
    end
  end
end

some_thing = SomeThing.new
validator_reflection = Reflect.(some_thing, :Validate)

# validator_reflection.(:call, some_thing, :some_state)
validator_reflection.!(:call, :some_state)
# => validate some_thing
```

# Additional Changes

## Target Method Predicate

``` ruby
class SomeThing
  module Validate
    def self.call(some_thing, state=nil)
      # validate some_thing, taking an account optional state
    end
  end
end

some_thing = SomeThing.new
validate_reflection = Reflect.(some_thing, :Validate)

validate_reflection.target_method?(:call)
# => true
```

## Arity Method

``` ruby
class SomeThing
  module Validate
    def self.call(some_thing, state=nil)
      # validate some_thing, taking an account optional state
    end
  end
end

some_thing = SomeThing.new
validate_reflection = Reflect.(some_thing, :Validate)

validate_reflection.arity(:call)
# => -2
```

## Parameters Method

``` ruby
class SomeThing
  module Validate
    def self.call(some_thing, state=nil)
      # validate some_thing, taking an account optional state
    end
  end
end

some_thing = SomeThing.new
validate_reflection = Reflect.(some_thing, :Validate)

validate_reflection.parameters(:call)
# => [[:some_thing, :req], [:state, :opt]]
```
