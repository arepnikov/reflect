# Reflect Library Improvements Proposal

## Background

In Eventide's libraries, Reflect has 6 use cases, but 4 of them do not utilize it in the designed way. Instead of making a use of the reflection's actuator, the constant is pulled from the reflection.

The actuator is designed to pass the subject into the method being invoked. Subject could be overriden when needed.

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

validator_reflection.(:call)
```

However, the actuator doesn't support methods with zero arity or methods with arity greater than one. Due to these limitations, the constant is extracted from the reflection, bypassing the actuator.

It has been observed that the reflection's actuator should support methods with any arity and allow the subject to be overridden when needed.

## Problem - Reflection's Actuator Only Supports Methods With Precisly One Argument

### Method Without Arguments

```ruby
class SomeClass
  module Substitute
    def self.build
      puts 'some substitute'
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
      puts 'some substitute'
    end
  end
end

some_instance = SomeClass.new
some_reflection = Reflect.(some_instance, :SomeModule)

some_reflection.(:build)
# => some substitute
```


### Method With More Than One Argument

```ruby
class SomeThing
  module Validate
    def self.call(some_thing, state)
      puts "validate some_thing"
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
      puts "validate some_thing"
    end
  end
end

some_thing = SomeThing.new
validator_reflection = Reflect.(some_thing, :Validate)

validator_reflection.(:call, some_thing, :some_state)
# => validate some_thing
```


## Reflection's Variant Actuator - Passing Subject and Methods With Any Parameter Signature

Support for methods with any parameter signature is proposed. This necessitates a way to instruct the reflection on whether it should pass the subject into the invoked method.

To address this, the introduction of a variant actuator method `.!()` is proposed. The variant actuator invariably will pass the subject into the invoked method.

```ruby
class SomeThing
  module Validate
    def self.call(some_thing, state)
      puts "validate some_thing"
    end
  end
end

some_thing = SomeThing.new
validator_reflection = Reflect.(some_thing, :Validate)

# validator_reflection.(:call, some_thing, :some_state)
validator_reflection.!(:call, :some_state)
# => validate some_thing
```
