class CreateUserSongRanks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_song_ranks do |t|
      t.integer :user_id
      t.integer :rank_num
      t.integer :song_id

      t.timestamps
    end
  end
end
