class ChangeRatingFromBoxoffices < ActiveRecord::Migration
  def change
    change_column :boxoffices, :rating, :string
  end
end
