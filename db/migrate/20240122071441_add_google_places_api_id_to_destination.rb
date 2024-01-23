class AddGooglePlacesApiIdToDestination < ActiveRecord::Migration[7.1]
  def change
    add_column :destinations, :google_places_api_id, :string
  end
end
