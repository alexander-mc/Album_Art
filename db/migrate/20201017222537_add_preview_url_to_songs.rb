class AddPreviewUrlToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :preview_url, :string
  end
end
