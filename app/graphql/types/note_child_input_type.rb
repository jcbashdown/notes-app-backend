module Types
  class NoteChildInputType < GraphQL::Schema::InputObject
    graphql_name 'NoteChildInputType'

    argument :relationship, String, required: true
    argument :note, Types::NoteInputType, required: true
  end
end

