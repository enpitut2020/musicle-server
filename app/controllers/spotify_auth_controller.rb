class SpotifyAuthController < ApplicationController
  def auth
    uri = URI.parse("https://accounts.spotify.com/api/token")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Basic " + Rails.application.credentials.spotify[:authorization_key]
    request.set_form_data({'grant_type' => 'authorization_code', 'code' => params[:code], 'redirect_uri' => 'http://localhost:8080/spotify-callback'})
    req_options = {
      use_ssl: true,
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
    end
    render json: response.body
  end
end
