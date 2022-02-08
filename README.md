Coercion not supported in json-schema Ruby library.
https://github.com/voxpupuli/json-schema/issues/22
https://github.com/voxpupuli/json-schema/issues/257#issue-93274476

Examples:
1. LoanApplicationSimpleSchema (using only dry-schema)
2. LoanApplicationValidator (using dry-validator and dry-schema)
3. LoanApplicationValidatorWithBase (as above but with parent class for more intuitive ways to call it (in my view))
4. Usage LoanApplicationValidatorWithBase


> https://dry-rb.org/
> 
> dry-rb is a collection of next-generation Ruby libraries, each
> intended to encapsulate a common task.
> 
> dry-rb helps you write clear, flexible, and more maintainable Ruby
> code. Each dry-rb gem fulfils a common task, and together they make a
> powerful platform for any kind of Ruby application.


> https://hanamirb.org/
> 
> Hanami consumes 60% less memory than other full-featured Ruby
> frameworks.
> 
> In the Ruby community it seems popular to use Hanami + rom-rb (ORM) +
> other dry-rb libraries


The 2 that we have used to date in the US Originations stack:

> https://dry-rb.org/gems/dry-schema/1.5/
> 
> dry-schema is a validation library for data structures. It ships with
> a set of many built-in predicates and powerful DSL to define even
> complex data validations with very concise syntax.
> 
> Main focus of this library is on:
> 
> - Data structure validation
> - Value types validation
> 
> dry-schema is used as the schema engine in dry-validation which is the
> recommended solution for business domain validations
> 
> 
> https://dry-rb.org/gems/dry-validation/1.6/
> 
> dry-validation is a data validation library that provides a powerful
> DSL for defining schemas and validation rules.
> 
> Validations are expressed through contract objects. A contract
> specifies a schema with basic type checks and any additional rules
> that should be applied. Contract rules are applied only once the
> values they rely on have been succesfully verified by the schema.
> 
> 
> There are a couple of unique features that make dry-validation stand
> out from the crowd:
> 
> - Strict, explicit data schemas are separated from the domain validation logic - this allows you to define validation rules that are
> type safe and focus exclusively on validation logic. This in turn
> makes rule code much simpler and easier to understand
> - Schemas are powered by dry-schema which sanitizes, coerces and type-checks the input for you
> - Contracts support defining macros, which can significantly reduce code duplication in your rules
> - Plays nice with dependency injection, using either option API or automated approach via dry-auto_inject
> 
> 
> https://dry-rb.org/gems/dry-types/1.2/ We have not used this library
> but the principle remains the same. We can define classes that inherit
> from Dry::Struct and configure attributes to be coercible.

```
class User < Dry::Struct
  attribute :name, Types::Coercible::String
  attribute :age,  Types::Coercible::Integer
end

User.new(name: 'Bob', age: '18')
# => #<User name="Bob" age=18>
User.new(name: 'Bob', age: 'not coercible')
# => ArgumentError: invalid value for Integer(): "not coercible"
```
