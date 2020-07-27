class UserController < ApplicationController

  def show
    @user = User.all
    #render json：@user

  end
end
