class CreateUserSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_songs do |t|
      t.string :spotify_id
      t.string :song_name
      t.string :artist_name

      t.timestamps
    end
  end
end
