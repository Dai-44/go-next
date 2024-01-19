class ChangeLatitudeAndLongitudeInDestinations < ActiveRecord::Migration[7.1]
  def up
    change_column :destinations, :latitude, :decimal, precision: 8, scale: 6
    change_column :destinations, :longitude, :decimal, precision: 9, scale: 6
  end
end
