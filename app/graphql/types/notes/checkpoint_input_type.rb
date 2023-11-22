module Types
  module Notes
    class CheckpointInputType < Types::BaseInputObject
      argument :updated_at, GraphQL::Types::ISO8601DateTime, required: false
    end
  end
end
