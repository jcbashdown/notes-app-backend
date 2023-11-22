module Types
  module Notes
    class NotesQueryType < Types::BaseObject
      field :synced_notes, Types::Notes::SyncedNotesType, null: false do
        argument :checkpoint, Types::Notes::CheckpointInputType, required: false
        argument :limit, Integer, required: false
      end

      def synced_notes(checkpoint: nil, limit: 100)
        min_updated_at = checkpoint&.updated_at || Time.at(0)

        notes = Note.order(updated_at: :asc)
                    .where("(updated_at > ?) OR (updated_at = ?)", min_updated_at, min_updated_at)
                    .limit(limit)

        {
          documents: notes,
          checkpoint: {
            updated_at: notes.last&.updated_at
          }
        }
      end
    end
  end
end
