module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def current_application_context
      #@current_application_context ||= ApplicationContext.new(cookies)
    end
  end
end
