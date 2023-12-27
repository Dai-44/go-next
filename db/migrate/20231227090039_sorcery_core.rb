class SorceryCore < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email,            null: false, index: { unique: true }
      t.string :crypted_password
      t.string :salt
      t.string :name, null:false
      t.float :nearest_station_latitude
      t.float :nearest_station_longitude

      t.timestamps                null: false
    end
  end
end
