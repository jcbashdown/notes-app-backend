module Types
  class NoteInputType < GraphQL::Schema::InputObject
    graphql_name 'NoteInputType'

    argument :text, String, required: true
    argument :id, String, required: false 
    argument :children, [Types::NoteChildInputType], required: false
  end
end
