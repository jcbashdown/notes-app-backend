module Types
  class FlatNoteInputType < GraphQL::Schema::InputObject
    graphql_name 'FlatNoteInputType'

    argument :text, String, required: true
    argument :id, String, required: true 
    argument :child_ids, [String], required: false
    argument :parent_ids, [String], required: false
  end
end
