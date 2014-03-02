class RemoveImportDateFromBoxoffices < ActiveRecord::Migration
  def change
    remove_column :boxoffices, :import_date
  end
end
