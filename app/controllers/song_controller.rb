class SongController < ApplicationController
    def song_list
        @songs = Song.all
        render json:@songs
    end
end
