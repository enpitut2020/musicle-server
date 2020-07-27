class UsersController < ApplicationController

  #曲情報を返す
  def song
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