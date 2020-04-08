class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.references :group, foreign_key: true
      t.integer :week
      t.integer :day_of_week

      t.timestamps
    end
  end
end
