class AddEnNameToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :en_name, :string
  end
end
