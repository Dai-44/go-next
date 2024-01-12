class AddVisitedMonthToDriveRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :drive_records, :visited_month, :string, null: false
  end
end
