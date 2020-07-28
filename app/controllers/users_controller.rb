class UsersController < ApplicationController
  def search
    #songs = UserSongRank.where(user_id: params[:id]).includes(:user_song)
    name = User.find(params[:id]).display_name
    ranks = UserSongRank.order(:rank_num).limit(5).where(user_id: params[:id]).includes(:user_song)
    songs_data = ranks.map {|rank| {name: rank.user_song.song_name, artistName: rank.user_song.artist_name} }
    render json: {name: name, topSongs: songs_data}
  end
end