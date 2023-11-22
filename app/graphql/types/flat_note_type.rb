# frozen_string_literal: true

module Types
  class FlatNoteType < Types::BaseObject
    field :id, ID, null: false
    field :text, String, null: true
    #TODO - change to flat ids
    #field :children, [Types::NoteType], null: true
    #field :parents, [Types::NoteType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
