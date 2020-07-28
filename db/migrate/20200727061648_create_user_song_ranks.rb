class CreateUserSongRanks < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_song_ranks, :song_id, :user_song_id
  end
end