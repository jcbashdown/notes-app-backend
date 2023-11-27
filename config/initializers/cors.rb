# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  #allow do
    #origins '*' # Replace with the URL of your frontend app

    #resource '/graphql',
      #headers: :any,
      #methods: [:get, :post, :options]
  #end
  allow do
    origins '*'
    resource '*',
      headers: :any,
      methods: [:get, :post, :patch, :put, :delete, :options, :head]
  end
end
