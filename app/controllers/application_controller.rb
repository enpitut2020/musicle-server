class ApplicationController < ActionController::API
    def hello
        #render html: "hello, world!"
        #messageでparamsの引数を受け取る
        @song = Song.all
        render json: @song
    end
end
