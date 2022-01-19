**Class Inheritence**

- Inheritence is when a class inherits behaviour (why dont we also say it inherits attribute) from other class
- The class that is inheriting behavior (and attributes) is called subclass and the class it inherits from is called the superclass
- We use the symbol `<` while defining to class to make one class inherit from another
- we can override the superclass's method in the parent class
- inheritence can be a great way to remove duplication in the code base

**super**

- when we call `super` from within a method, it searches the method lookup path for a method with same name and then invokes it.

- More common way of using `super` is with `initliaze` method
  - when we use `super` without any arguments, it forwards the arguments, which were passed into the method from which `super` is called, to the `initialize` method in the superclass
  - when `super(a, b)` is called with specific arguments - only those arguments are forwarded
  - when `super()` is called with only the paranthesis - it calls the method in superclass with no arguments

**Mixing in Modules**

- Extracting common methods to a superclass is a natural way to model concepts which are hierarchical
- But sometimes we want to have common behaviours in objects which do not have a hierarchical relation

**Inheritance versus Modules**

- 2 ways in which Ruby implements inheritence
- class inheritence - 1 type inherits behaviours of other types - the result is a new type which specialized the superclass
- the other type is called interface inheritence - the class does not inherit from other class - rather inherits the behaviour provided by the mixin module
  - a class can inherit from 1 class only - but we can mix in as many modules as possible
  - For "is-a" type relationship - class inheritence is a natural choice. For "has-a" type relationhip, interface inheritence is a natural choice
  - you can not instantiate modules - they are only for namespacing and grouping common methods together

**Method Lookup Path**

- method lookup path is the order in which classes are inspected when you call a method
- the first class inspected is the class of the object itself
- then the modules included in that classes in bottom up order
- then the superclass and the modules included in the superclass
- and so on

- once ruby finds the method - it looks no more

**More Modules**

- Modules can be used to `mix-in` behaviours into classes

- 2 more things

- Namespacing

  - organizing similar classes under a module
  - we call classes in module by appending the class name to the module name with 2 colons `::`

- Second use case is using modules as container for methods

**Private, Protected and Public**

- Access Control exists in a number of programming language. In Ruby, we are concerned about restricting access to methods defined in a class - a concept known as Method Access Control

- By default, all instance methods or class methods are public ie they are available to anyone who knows the class name or the object name

- sometimes we need methods which are available only within the class - do that by using the keyword `private`

- it is now legal to prepend `self` to the invocatio of private methods

- protected methods are available from within a class but not accessible from outside the class

**Accidental Method Overriding**

- Methods defined in the `Object` class are available in all classes
- through inheritence, we can override the methods of the parent class
- its important to be aware of some of the common `Object` methods and not override the common methods - unless we explicitly want to - like the `to_s` method
