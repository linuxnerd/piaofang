class AddAreaToBoxoffices < ActiveRecord::Migration
  def change
    add_column :boxoffices, :area, :string
  end
end
