require 'net/http'
require 'uri'

class ApplicationController < ActionController::API
    def hello
        #render html: "hello, world!"
        #messageでparamsの引数を受け取る
        #@song = Song.all
        #render json: @song
        uri = URI.parse("https://api.spotify.com/v1/artists/1O8CSXsPwEqxcoBE360PPO")
        request = Net::HTTP::Get.new(uri)
        request["Authorization"] = "Bearer BQByVh-pQ0EtYWt7f21dA3c4j-HPsEAaWx_OyCEaAObhyHaHG_lsrCUQW8NBexGcndzON2ZFFV8jHv0IUu8"

        req_options = {
        use_ssl: uri.scheme == "https",
        }

        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
            http.request(request)
        end
        render json: response.body
        #gon.token = auth_params["access_token"]
    # response.code
    # response.body
 end
end
