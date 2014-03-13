class AddSourceToBoxoffices < ActiveRecord::Migration
  def change
    add_column :boxoffices, :source, :string
  end
end
