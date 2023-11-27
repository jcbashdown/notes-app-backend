module Types
  class SubscriptionType < Types::BaseObject
    description "The subscription root for the GraphQL schema"
    field :note_changed, subscription: Subscriptions::Notes::NoteChanged
  end
end
