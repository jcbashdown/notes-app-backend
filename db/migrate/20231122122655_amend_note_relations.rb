class AmendNoteRelations < ActiveRecord::Migration[7.1]
  def change
    #remove the foreign key constraint from the parent_note_id and child_note_id columns of the note_relations table but keep the columns and column index
    remove_foreign_key :note_relations, :notes, column: :parent_note_id
    remove_foreign_key :note_relations, :notes, column: :child_note_id
  end
end
