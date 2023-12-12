class CreateFeelingTypeMappings < ActiveRecord::Migration[7.1]
  def change
    create_table :feeling_type_mappings do |t|
      t.references :feeling, null: false
      t.references :google_places_api_type, null: false

      t.timestamps
    end
  end
end
