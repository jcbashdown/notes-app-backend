module Types
  module Notes 
    class FlatNoteInputType < GraphQL::Schema::InputObject
      graphql_name 'FlatNoteInputType'

      argument :text, String, required: true
      argument :id, String, required: true 
      argument :child_ids, [String], required: false, default_value: []
      argument :parent_ids, [String], required: false, default_value: []
      argument :created_at, GraphQL::Types::ISO8601DateTime, required: true
      argument :updated_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :_deleted, Boolean , required: false
    end
  end
end
