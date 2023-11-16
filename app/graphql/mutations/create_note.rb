module Mutations
  class CreateNote < Mutations::BaseMutation
    argument :input, Types::NoteInputType, required: true

    field :note, Types::NoteType, null: false
    field :errors, [String], null: false

    def resolve(input:)
      note = Note.new(text: input[:text])

      if note.save
        handle_children(note, input[:children]) if input[:children].present?

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

    def handle_children(parent_note, children)
      children.each do |child_input|
        child_note = create_or_find_child_note(child_input[:note])

        NoteRelation.create!(parent_note_id: parent_note.id, child_note_id: child_note.id)

        if child_input[:note][:children].present?
          handle_children(child_note, child_input[:note][:children])
        end
      end
    end

    def create_or_find_child_note(note_input)
      child_note = note_input[:id] ? Note.find_or_initialize_by(id: note_input[:id]) : Note.new
      child_note.text = note_input[:text]
      child_note.save!
      child_note
    end
  end
end
