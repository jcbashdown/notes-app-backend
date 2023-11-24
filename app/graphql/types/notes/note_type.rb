# frozen_string_literal: true

module Types
  module Notes 
    class NoteType < Types::BaseObject
      field :id, ID, null: false
      field :text, String, null: true
      field :children, [Types::Notes::NoteType], null: true
      field :parents, [Types::Notes::NoteType], null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
