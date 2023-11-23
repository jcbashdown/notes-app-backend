module Types
  module Notes
    class NoteChangeInputType < GraphQL::Schema::InputObject
      argument :assumed_master_state, FlatNoteInputType, required: false
      argument :new_document_state, FlatNoteInputType, required: true
    end
  end
end
