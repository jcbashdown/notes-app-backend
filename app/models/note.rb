class Note < ApplicationRecord
  #In future, relations will need to have a type, so that we can have different types of relations.
  has_many :child_relations, class_name: 'NoteRelation', foreign_key: 'parent_note_id'
  has_many :parent_relations, class_name: 'NoteRelation', foreign_key: 'child_note_id'
  has_many :children, through: :child_relations, source: :child_note
  has_many :parents, through: :parent_relations, source: :parent_note

  after_save :broadcast_note_change
  after_destroy :broadcast_note_deletion

  def parent_ids
    parent_relations.pluck(:parent_note_id)
  end

  def child_ids
    child_relations.pluck(:child_note_id)
  end

  private

  def broadcast_note_change
    note = {
      note_changes: {
        documents: {
          id: self.id,
          text: self.text,
          child_ids: self.child_relations.pluck(:child_note_id),
          parent_ids: self.parent_relations.pluck(:parent_note_id)
        }
      }
    }
    #Subscriptions::Notes::NoteChanged.trigger("noteChanged", {}, { note_changes: {checkpoint: DateTime.now.iso8601, documents: [note]}})
    NotesAppBackendSchema.subscriptions.trigger(
      :note_changed,  # Field name
      {},             # Arguments
      note,      # Object with the note changes data
    )
  end
  def broadcast_note_deletion
    note = {
      note_changes: {
        documents: {
          id: self.id,
          text: self.text,
          child_ids: self.child_relations.pluck(:child_note_id),
          parent_ids: self.parent_relations.pluck(:parent_note_id),
          _deleted: true
        }
      }
    }
    NotesAppBackendSchema.subscriptions.trigger(
      :note_changed,  # Field name
      {},             # Arguments
      note,      # Object with the note changes data
    )
  end
end
