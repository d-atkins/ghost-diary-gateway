class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.references :group, foreign_key: true
      t.integer :week, default: 0
      t.integer :day_of_week, default: 0

      t.timestamps
    end
  end
end
