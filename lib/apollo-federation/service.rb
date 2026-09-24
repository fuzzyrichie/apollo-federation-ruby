# frozen_string_literal: true

require 'graphql'

module ApolloFederation
  class Service < GraphQL::Schema::Object
    graphql_name '_Service'
    description 'The sdl representing the federated service capabilities. Includes federation ' \
      'directives, removes federation types, and includes rest of full schema after schema ' \
      'directives have been applied'

    # hash_key: (not a plain field(:sdl, ...)) is required for GraphQL::Execution::Next: the
    # backing object here is a bare `{ sdl: ... }` Hash (see ServiceField#_service), and
    # classic's Field#resolve has a built-in Hash-key fallback that Next's default :direct_send
    # mode doesn't replicate -- without this, :direct_send calls `.sdl` directly on the Hash and
    # raises `NoMethodError: undefined method 'sdl' for an instance of Hash`.
    field(:sdl, String, null: true, hash_key: :sdl)
  end
end
