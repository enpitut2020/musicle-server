class ApplicationController < ActionController::API
    def hello
        #render html: "hello, world!"
        #messageでparamsの引数を受け取る
        render json: {"message": params[:message]}
    end
end
