1. Introduction

2. Equivalence

- when we compare, say 2 strings, using the `==` Ruby somehow knows that we are trying to check if their values are equal
- what if we want to check if 2 variables actually point to the same object - we use `#equal?`
- `==` is not an operator in Ruby, its a method - defined in the `BasicObject` class which is the parent class for all classes in Ruby - ie every object has a `==` method
- by default, the implementation for `==` is `equal?` - for `==` to work as we intend, ie making it to compare value, we have to overide the default and define `==` instance method
- if we define `==`, we get `!=` automatically
- if 2 symbols or 2 ints have the same value, they are the same objects in Ruby
- `===` looks like an operator, but is a method - invoked on a group and returns true if the group contains the passed in argument
  - `String === "hello" #=> true`
  - `(1..50) === 25 #=> true`
- `eql?` - very rarely used explicitly, used implicitly by `Hash`

3. Variable Scope

- Instance variable scope

  - instance variables start with `@` and scoped at object level. They are used to track an individual object's state
  - since instance vars are scoped at object levels, they are accessible in object's instance methods - even if they are initialized outside of that instance method
  - unlike local variables, instance variables do not need to be explicitly passed into the method - further reinforcing the point that their scope is at the object level
  - `#instance_variables` returns the array of all instance variables
  - untill an instance variable is initialized in an instance method, it is not returned by the `instance_variables` method
  - when used before initializaion an instance variable will return `nil`, unlike local variables which will throw a `NameError`
  - never put instance variable at a class level

- Class Variable Scope

  - start with `@@` and are scoped at class level

    - all objects share the same class variable
    - both class methods and instance methods can access the class variables, regardless of where it is initialized

  - unlike instance variable, class variables share state between the instances

- Constant Variable Scope

  - constants are accessible in both the class method scope and instance method scope
  - gets tricky in the case of inheritence as they follow lexical scope

4. Inheritance and Variable Scope

- Instance Variables

  - We must first call the method that initializes the instance variables - else any reference to that instance variable will return `nil`
  - unlike instance methods, instance variables and their values are not inherited

- Class Variables

  - They are available in the children classes
  - However, since they can be modified from anywhere - we should not use them while inheriting classes - because sub-class can modify super-class or other sub-class 's class variable

- Constants

  - Unlike instance or class variables, we can refer constants from other class using the namespace resolution `::` operator
  - The scope of constant is pretty straightforward in case of inheritence
  - However, constants are not evaluated at runtime. So their lexical scope - ie where they are in code - becomes very important.

5. Fake Operators

- When implementing some functionality, we need to make sure that the functionality makes sense
- ie the functionality of `+` must be either incrementing or concatenating objects
- out of all the fake operators the collection getters and setters ie `.[]()` and `.[]=(a, b)` are probably the most extreme and we need to be careful while implementing them
-
