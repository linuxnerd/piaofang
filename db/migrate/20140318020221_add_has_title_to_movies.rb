class AddHasTitleToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :has_subtitle, :boolean, default: false
  end
end
