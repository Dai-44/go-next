class CreateGooglePlacesApiTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :google_places_api_types do |t|
      t.string :name
      t.string :display_name
      t.references :feeling, null: false, foreign_key: true

      t.timestamps
    end
  end
end
