class CreateBoxoffices < ActiveRecord::Migration
  def change
    create_table :boxoffices do |t|
      t.date :import_date
      t.integer :rid
      t.string :name
      t.string :wk
      t.string :wboxoffice
      t.string :tboxoffice

      t.timestamps
    end
  end
end
