class CreateHonors < ActiveRecord::Migration
  def change
    create_table :honors do |t|
      t.string :session
      t.string :year
      t.string :award_name
      t.string :award_type
      t.string :name
      t.string :festival

      t.timestamps
    end
  end
end
