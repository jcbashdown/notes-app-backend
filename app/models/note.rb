class Note < ApplicationRecord
  #In future, relations will need to have a type, so that we can have different types of relations.
  has_many :child_relations, class_name: 'NoteRelation', foreign_key: 'parent_note_id'
  has_many :parent_relations, class_name: 'NoteRelation', foreign_key: 'child_note_id'
  has_many :children, through: :child_relations, source: :child_note
  has_many :parents, through: :parent_relations, source: :parent_note
end
