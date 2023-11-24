# frozen_string_literal: true
module Types
  module Notes 
    class FlatNoteType < GraphQL::Schema::Object
      field :id, ID, null: false
      field :text, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :parent_ids, [ID], null: true
      field :child_ids, [ID], null: true

      def parent_ids
        object.parent_relations&.pluck(:parent_note_id)&.compact || []
      end

      def child_ids
        object.child_relations&.pluck(:child_note_id)&.compact || []
      end
    end
  end
end
