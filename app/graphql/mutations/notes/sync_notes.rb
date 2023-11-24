require 'ostruct'

module Mutations
  module Notes 
    class SyncNotes < GraphQL::Schema::Mutation
      graphql_name 'SyncNotes'

      argument :changes, [Types::Notes::NoteChangeInputType], required: true

      field :conflicts, [Types::Notes::FlatNoteType], null: false

      def resolve(changes:)
        conflicts = []

        changes.each do |change|
          conflict = process_note_change(change)
          conflicts << conflict if conflict
        end

        { conflicts: conflicts }
      end

      private

      def process_note_change(change)
        master_note = Note.find_by(id: change.assumed_master_state&.id)
        #create a copy of the change.new_document_state without the _deleted key
        #clean_new_document_state = OpenStruct.new({
          #text: change.new_document_state.text,
          #child_ids: change.new_document_state.child_ids,
          #parent_ids: change.new_document_state.parent_ids,
        #})
        return master_note if master_note && !master_note_matches?(master_note, change.assumed_master_state) #&& !master_note_matches?(master_note, clean_new_document_state)
        #TODO? if the master note doesn't exist, but assumed_master_state thinks it does then this should probably also be a conflict?

        # If the newDocumentState has _deleted set to true, handle deletion
        if change.new_document_state&._deleted
          handle_deletion(change.new_document_state.id)
          return nil
        end

        note = Note.find_or_initialize_by(id: change.new_document_state.id)
        note.text = change.new_document_state.text
        note.save!

        update_relations(note, change.new_document_state)

        nil
      end
      def master_note_matches?(note, master_state)
        note.text == master_state&.text &&
          note.child_ids.sort == master_state&.child_ids&.sort &&
          note.parent_ids.sort == master_state&.parent_ids&.sort
      end
      def update_relations(note, state)
        current_parent_ids = note.parent_relations.pluck(:parent_note_id)
        current_child_ids = note.child_relations.pluck(:child_note_id)

        # Add new relations
        (state.parent_ids - current_parent_ids).each do |parent_id|
          NoteRelation.create!(parent_note_id: parent_id, child_note_id: note.id)
        end

        (state.child_ids - current_child_ids).each do |child_id|
          NoteRelation.create!(parent_note_id: note.id, child_note_id: child_id)
        end

        # Remove old relations
        (current_parent_ids - state.parent_ids).each do |parent_id|
          note.parent_relations.where(parent_note_id: parent_id).delete_all
        end

        (current_child_ids - state.child_ids).each do |child_id|
          note.child_relations.where(child_note_id: child_id).delete_all
        end
      end
      def handle_deletion(note_id)
        note = Note.find_by(id: note_id)
        return unless note
        note.parent_relations.delete_all
        note.child_relations.delete_all

        # Delete the note and its relations
        note.destroy
      end
    end
  end
end
