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
    puts response 
    render json: response.body
    #曲情報を返す
    uri1 = URI.parse("https://api.spotify.com/v1/me/top/tracks")
    request1 = Net::HTTP::Get.new(uri1)
    request1["Authorization"] = "Bearer " + JSON.parse(response.body)[:access_token]
    req_options1 = {
      use_ssl: uri.scheme == "https",
    }
    response1 = Net::HTTP.start(uri1.hostname, uri1.port, req_options) do |http|
      http.request(request1)
    end
    render json: response1.body
  end
end
