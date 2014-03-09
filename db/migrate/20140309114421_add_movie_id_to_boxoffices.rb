class AddMovieIdToBoxoffices < ActiveRecord::Migration
  def change
    add_column :boxoffices, :movie_id, :integer
    add_index :boxoffices, :movie_id
  end
end
