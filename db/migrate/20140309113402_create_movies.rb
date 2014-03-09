class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :poster_url
      t.string :rating
      t.string :director
      t.string :actors
      t.string :types
      t.string :release_date
      t.text :summary

      t.timestamps
    end

    add_index :movies, :name, unique: true

  end
end
