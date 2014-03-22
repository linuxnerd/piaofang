class ChangeTorrentUrlFromMovies < ActiveRecord::Migration
  def change
    change_column :movies, :torrent_url, :text
  end
end
