module Resolvers
  module Notes
    class NotesQueryResolver < Resolvers::BaseResolver
      type Types::Notes::NotesQueryType, null: false

      def resolve
        # Here you can include any logic you need before accessing NotesQueryType
        # For now, let's just return an empty object as a placeholder
        {}
      end
    end
  end
end
