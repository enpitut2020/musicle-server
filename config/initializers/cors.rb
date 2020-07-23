Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:8080', 'musicle-app.web.app'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end