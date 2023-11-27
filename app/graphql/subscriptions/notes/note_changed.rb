module Subscriptions
  module Notes
    class NoteChanged < Subscriptions::BaseSubscription
      field :note_changes, Types::Notes::SimpleSyncedNotesType, null: false do
        argument :checkpoint, Types::Notes::CheckpointInputType, required: false
        argument :limit, Integer, required: false
        #argument :headers, Types::HeadersType, required: false
      end
    end
  end
end
