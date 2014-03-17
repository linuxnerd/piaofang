class AddColumnToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :torrent_url, :string
    add_column :movies, :torrent_type, :string
  end
end
