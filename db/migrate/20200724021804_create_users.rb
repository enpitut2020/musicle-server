class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :spotify_id

      t.timestamps
    end
  end
end
