class AddIndexToGooglePlacesApiTypes < ActiveRecord::Migration[7.1]
  def change
    add_index :google_places_api_types, :name
  end
end
