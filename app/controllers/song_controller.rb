class SongController < ApplicationController
    def song_list
        render json: UserSongRank.where(user_id: params[:uid])
    end
end
