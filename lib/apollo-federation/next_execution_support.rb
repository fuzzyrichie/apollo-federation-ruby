# frozen_string_literal: true

require 'graphql'

module ApolloFederation
  # `resolve_static:` (and GraphQL::Execution::Next generally) doesn't exist on every
  # graphql-ruby version this gem supports, so detect it at the Field#initialize signature
  # rather than assuming a minimum graphql-ruby version. Shared by any field this gem defines
  # directly on the Query type (currently _entities and _service), since those are resolved
  # against the wrapped Query object under classic but the (nil, by default) Query root_value
  # under Next's default :direct_send -- resolve_static is what makes them agree.
  RESOLVE_STATIC_SUPPORTED = GraphQL::Schema::Field.instance_method(:initialize).parameters.any? do |_type, name|
    name == :resolve_static
  end
end
