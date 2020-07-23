class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.integer :rank_num
      t.string :song_name
      t.string :artist_name

      t.timestamps
    end
  end
end
