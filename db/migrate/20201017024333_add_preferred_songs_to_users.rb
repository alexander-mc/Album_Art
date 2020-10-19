class AddPreferredSongsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :preferred_songs, :string
  end
end
