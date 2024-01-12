class CreateDestinations < ActiveRecord::Migration[7.1]
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.references :google_places_api_type, null: true, foreign_key: true
      # google_places_api_typeを参照しないDestinationレコードも稀に存在すると想定されるため、外部キーがnullの場合でも許容する旨を明示的に記述している。

      t.timestamps
    end
  end
end
