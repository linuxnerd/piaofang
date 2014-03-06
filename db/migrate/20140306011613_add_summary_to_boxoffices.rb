class AddSummaryToBoxoffices < ActiveRecord::Migration
  def change
    add_column :boxoffices, :summary, :string
  end
end
