class AddIndexToDestinations < ActiveRecord::Migration[7.1]
  def change
    add_index :destinations, :google_places_api_id
  end
end
