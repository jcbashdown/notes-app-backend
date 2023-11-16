class CreateNoteRelations < ActiveRecord::Migration[7.1]
  def change
    create_table :note_relations do |t|
      t.uuid :parent_note_id
      t.uuid :child_note_id

      t.timestamps
    end

    add_index :note_relations, :parent_note_id
    add_index :note_relations, :child_note_id

    # Add foreign key constraints
    add_foreign_key :note_relations, :notes, column: :parent_note_id
    add_foreign_key :note_relations, :notes, column: :child_note_id
  end
end
