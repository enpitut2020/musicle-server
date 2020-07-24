class UsersController < ApplicationController
  def song
    @song = Song.all
    render json: @song
  end
end