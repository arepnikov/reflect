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

# Reflect Changes

## Actuate Methods That Don't Have Parameters

``` ruby
class SomeThing
  module Substitute
    def self.build
      # ...
    end
  end
end

substitute_reflection = Reflect.(some_thing, :Substitute)

build_method = substitute_reflection.target_method?(:build)
# => true

build_method = substitute_reflection.target_method(:build)
# -or-
build_method = substitute_reflection[:build]
# -or-
build_method = substitute_reflection.^(:build)

build_method.()
```

## Actuate Protocol Methods With Variable Arity

``` ruby
## Arity of two
class SomeThing
  module Validate
    def self.call(some_thing, state=nil)
      state ||= []
      # ...
      state.empty?
    end
  end
end

validate_reflection = Reflect.(some_thing, :Validate)

call_method = substitute_reflection[:call]

call_method.arity
# => -2

call_method.parameters
# => [[:some_thing, :req], [:state, :opt]]

state = []
call_method.(some_thing, state)

# some_thing is the reflection's subject, variant supplies it as first positional argument
call_method.!(state)


## Arity of one
class SomeOtherThing
  module Validate
    def self.call(some_other_thing)
      # ...
      some_other_thing.valid?
    end
  end
end

validate_reflection = Reflect.(some_other_thing, :Validate)

call_method = validate_reflection[:call]

call_method.arity(:call)
# => 1

call_method.(some_thing)
call_method.!()
```

## Detect If Reflection Target Is A Circular Reference

``` ruby
module Dependency
  module Substitute
    def self.build(cls)
      substitute_reflection = Reflect.(cls, :Substitute)

      if substitute_reflection.constant?(self)
        raise "No substitute module"
      end

      build_method = substitute_reflection[:build]

      if not build_method.nil?
        substitute = build_method.()

        return substitute
      end

      # Return a mimic ...
    end
  end
end

class SomeThing
  module Substitute
    def self.build
      # ...
    end
  end
end

class SomeOtherThing
end

class YetAnotherThing
  module Substitute
    def some_method
    end
  end
end

# SomeThing has a Substitute module with a .build method
Dependency::Substitute.build(SomeThing)

# Error, SomeOtherThing doesn't have a Substitute module
Dependency::Substitute.build(SomeOtherThing)

# YetAnotherThing has Substitute module without a .build method
Dependency::Substitute.build(YetAnotherThing)
```

## Shortcuts

### Reflection Actuator

``` ruby
some_reflection.(:some_method, 'some arg')
# Eqivalent:
some_method = some_reflection[:some_method]
some_method.('some arg')
```

### Reflection Variant Actuator

``` ruby
some_reflection.!(:some_method)
# Equivalent:
some_method = some_reflection[:some_method]
some_method.!
```

