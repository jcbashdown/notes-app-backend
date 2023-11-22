module Types
  module Notes
    class SyncedNotesType < Types::BaseObject
      field :documents, [Types::NoteType], null: true
      field :checkpoint, Types::Notes::CheckpointType, null: true
    end
  end
end
