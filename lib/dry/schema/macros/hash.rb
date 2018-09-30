require 'dry/schema/macros/value'

module Dry
  module Schema
    module Macros
      class Hash < Value
        def call(&block)
          hash?

          definition = schema_dsl.new(&block)

          parent_type = schema_dsl.types[name]
          definition_schema = definition.type_schema

          schema_type = parent_type.array? ? parent_type.of(definition_schema) : definition_schema
          schema_dsl.types[name] = (parent_type.maybe? ? schema_type.optional : schema_type).safe

          trace << definition

          self
        end
      end
    end
  end
end
