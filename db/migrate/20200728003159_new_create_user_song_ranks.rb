class NewCreateUserSongRanks < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_song_ranks, :user_song, index: true
  end
end
