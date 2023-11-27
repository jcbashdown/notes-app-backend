#In future, relations will need to have a type, so that we can have different types of relations.
#As a result we have a specific relation model like this.
class NoteRelation < ApplicationRecord
  belongs_to :parent_note, class_name: 'Note'
  belongs_to :child_note, class_name: 'Note'

end
