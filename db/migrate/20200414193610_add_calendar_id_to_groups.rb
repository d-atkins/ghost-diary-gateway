class AddCalendarIdToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :calendar_id, :string
  end
end
