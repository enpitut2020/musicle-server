class Init < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :spotify_id
      t.string :display_name

      t.timestamps
    end

    create_table :user_songs do |t|
      t.string :spotify_id
      t.string :song_name
      t.string :artist_name

      t.timestamps
    end

    create_table :user_song_ranks do |t|
      t.integer :user_id
      t.integer :rank_num
      t.references :user_song
      
      t.timestamps
    end
  end
end
