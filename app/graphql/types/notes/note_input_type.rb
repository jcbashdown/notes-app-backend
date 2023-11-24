module Types
  module Notes 
    class NoteInputType < GraphQL::Schema::InputObject
      graphql_name 'NoteInputType'

      argument :text, String, required: true
      argument :id, String, required: false 
      argument :children, [Types::Notes::NoteChildInputType], required: false
    end
  end
end
