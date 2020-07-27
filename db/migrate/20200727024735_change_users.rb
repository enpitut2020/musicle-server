class ChangeUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :name, :email
    add_column :users, :spotify_id, :string
  end
end
