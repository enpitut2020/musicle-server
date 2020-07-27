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
    me = get_me(JSON.parse(response.body)["access_token"])
    user = set_data(me["id"])
    render json: {id: user.id}
  end
    
  def get_me(access_token)
    uri = URI.parse("https://api.spotify.com/v1/me")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer " + access_token

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    # response.code
    return JSON.parse(response.body)
  end

  def set_data(userid)  #if処理
    return User.where(spotify_id: userid).first_or_create
  end

  def music
    #曲情報を返す
    uri1 = URI.parse("https://api.spotify.com/v1/me/top/tracks")
    request1 = Net::HTTP::Get.new(uri1)
    request1["Authorization"] = "Bearer " + JSON.parse(response.body)["access_token"]
    req_options1 = {
      use_ssl: uri.scheme == "https",
    }
    response1 = Net::HTTP.start(uri1.hostname, uri1.port, req_options) do |http|
      http.request(request1)
    end
    render json: response1.body
  end

end
