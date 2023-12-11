class CreateFeelingTypeMappings < ActiveRecord::Migration[7.1]
  def change
    create_table :feeling_type_mappings do |t|
      t.references :feeling, null: false, foreign_key: true
      t.references :google_places_api_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
