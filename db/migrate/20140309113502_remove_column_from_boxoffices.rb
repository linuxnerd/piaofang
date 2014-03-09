class RemoveColumnFromBoxoffices < ActiveRecord::Migration
  def change
    remove_column :boxoffices, :name
    remove_column :boxoffices, :image_url
    remove_column :boxoffices, :rating
    remove_column :boxoffices, :director
    remove_column :boxoffices, :actors
    remove_column :boxoffices, :types
    remove_column :boxoffices, :release_date
    remove_column :boxoffices, :summary
  end
end
