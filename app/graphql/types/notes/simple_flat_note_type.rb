# frozen_string_literal: true
module Types
  module Notes 
    class SimpleFlatNoteType < GraphQL::Schema::Object
      field :id, ID, null: false
      field :text, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :parent_ids, [ID], null: true
      field :child_ids, [ID], null: true
      field :_deleted, Boolean, null: true


    end
  end
end
