module Types
  module Notes
    class CheckpointType < Types::BaseObject
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true 
    end
  end
end
