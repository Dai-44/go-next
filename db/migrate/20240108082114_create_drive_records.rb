class CreateDriveRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :drive_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :destination, null: false, foreign_key: true

      t.timestamps
    end
  end
end
