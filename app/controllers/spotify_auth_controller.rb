require 'jwt'

class SpotifyAuthController < ApplicationController
  def auth
    uri = URI.parse("https://accounts.spotify.com/api/token")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Basic " + Rails.application.credentials.spotify[:authorization_key]
    request.set_form_data({'grant_type' => 'authorization_code', 'code' => params[:code], 'redirect_uri' => params["redirect_uri"]})
    req_options = {
      use_ssl: true,
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
    end
    puts response 
    me = get_me(JSON.parse(response.body)["access_token"])

    user = set_data(me["id"], me["display_name"])
    songname = song(JSON.parse(response.body)["access_token"])
    #puts songname
    #puts songname["items"]
    song_data(songname["items"], user.id)

    token = gen_token(user.id)
    render json: { token: token, uid: user.id }
  end

  def gen_token(user_id)
    hmac_secret = Rails.application.credentials.secret_key_base
    payload = { user_id: user_id }
    return JWT.encode payload, hmac_secret, 'HS256'
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

  def set_data(userid, display)  #if処理
    return User.where(spotify_id: userid).first_or_create do |userset| 
      userset.display_name = display
    end
  end

  def song(access2)
    #曲情報を返す
    uri1 = URI.parse("https://api.spotify.com/v1/me/top/tracks")
    request1 = Net::HTTP::Get.new(uri1)
    request1["Authorization"] = "Bearer " + access2
    req_options1 = {
      use_ssl: uri1.scheme == "https",
    }
    response1 = Net::HTTP.start(uri1.hostname, uri1.port, req_options1) do |http|
      http.request(request1)
    end
    return JSON.parse(response1.body)
  end

  def song_data(item, u_id)
    num = 1
    item.map do |param|
      song = UserSong.where(spotify_id: param["id"]).first_or_create do |song| 
        song.song_name = param["name"]
        song.artist_name =  param["artists"].map{ |artist| artist["name"]}.join(', ').strip
      end


      rank = UserSongRank.find_or_initialize_by(
        user_id: u_id,
        rank_num: num,
      )
      rank.update!(user_song_id: song.id)
      num += 1
    end
  end

end
