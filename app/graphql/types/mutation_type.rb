# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_note, mutation: Mutations::Notes::CreateNote
    field :sync_notes, mutation: Mutations::Notes::SyncNotes
  end
end
