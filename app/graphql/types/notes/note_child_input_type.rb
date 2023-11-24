module Types
  module Notes 
    class NoteChildInputType < GraphQL::Schema::InputObject
      graphql_name 'NoteChildInputType'

      argument :relationship, String, required: true
      argument :note, Types::Notes::NoteInputType, required: true
    end
  end
end

