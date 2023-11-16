class Mutations::CreateNote < Mutations::BaseMutation

  argument :text, String, required: true

  field :note, Types::NoteType, null: false
  field :errors, [String], null: false

  def resolve(text:)
    note = Note.new(text: text)
    if note.save
      # Successful creation, return the created object with no errors
      {
        note: note,
        errors: []
      }
    else
      # Failed save, return the errors to the client
      {
        note: nil,
        errors: note.errors.full_messages
      }
    end
  end
end

{
  text: "this is the parent"
  children: [
    {
      relationship: "child",
      note: {
        text: "This is a child note"
        children: [
          {
            relationship: "child",
            note: {
              id: "uuid"
              text: "This is a child of a child. This note is expected to already exist in the db with the provided id. If it doesn't exist then it should be created with a newly generated uuid"
            }
          }
        ]
      }
    }
  ] 
}
