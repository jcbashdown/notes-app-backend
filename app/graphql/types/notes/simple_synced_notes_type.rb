module Types
  module Notes
    class SimpleSyncedNotesType < Types::BaseObject
      field :documents, [Types::Notes::SimpleFlatNoteType], null: true
      field :checkpoint, Types::Notes::CheckpointType, null: true
    end
  end
end
