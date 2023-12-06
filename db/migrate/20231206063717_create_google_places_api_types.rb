class CreateGooglePlacesApiTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :google_places_api_types do |t|
      t.string :name
      t.string :display_name

      t.timestamps
    end
  end
end
