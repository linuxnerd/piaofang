class ChangeSummaryFromBoxoffices < ActiveRecord::Migration
  def change
    change_column :boxoffices, :summary, :text
  end
end
