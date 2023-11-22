module Mutations
  module Note 
    class CreateFlatNote < Mutations::BaseMutation
      argument :input, Types::FlatNoteInputType, required: true

      field :note, Types::FlatNoteType, null: false
      field :errors, [String], null: false

      def resolve(input:)
        #find or initialize by id
        note = Note.find_or_initialize_by(id: input[:id])
        note.text = input[:text]

        if note.save
          handle_children(note, input[:child_ids]) if input[:child_ids].present?
          handle_parents(note, input[:parent_ids]) if input[:parent_ids].present?

          {
            note: note,
            errors: []
          }
        else
          {
            note: nil,
            errors: note.errors.full_messages
          }
        end
      end

      private

      def handle_children(parent_note, child_ids)
        child_ids.each do |id|
          #TODO here - create the relation whether or not the not exists as we trust it will be created later.
          #likely means changing db
          NoteRelation.create!(parent_note_id: parent_note.id, child_note_id: id)
        end
      end
      def handle_parents(child_note, parent_ids)
        parent_ids.each do |id|
          #TODO here - create the relation whether or not the not exists as we trust it will be created later.
          #likely means changing db
          NoteRelation.create!(parent_note_id: id, child_note_id: child_note.id)
        end
      end
    end
  end
end
