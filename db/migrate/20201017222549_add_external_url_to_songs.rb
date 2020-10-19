class AddExternalUrlToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :external_url, :string
  end
end
