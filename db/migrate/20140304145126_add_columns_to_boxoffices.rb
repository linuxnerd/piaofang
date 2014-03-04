class AddColumnsToBoxoffices < ActiveRecord::Migration
  def change
    add_column :boxoffices, :image_url, :string
    add_column :boxoffices, :rating, :precision => 1
    add_column :boxoffices, :director, :string
    add_column :boxoffices, :actors, :string
    add_column :boxoffices, :types, :string
    add_column :boxoffices, :release_date, :date
    add_column :boxoffices, :year, :string
  end
end
