class ChangeReleaseDateFromBoxoffices < ActiveRecord::Migration
  def change
    change_column :boxoffices, :release_date, :string
  end
end
