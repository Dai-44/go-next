class RemoveForeignKeyConstraintFromFeelingTypeMappings < ActiveRecord::Migration[7.1]
  def change
    # FeelingTypeMappings テーブルから外部キー制約を削除
    remove_foreign_key :feeling_type_mappings, :feelings, column: :feeling_id
    remove_foreign_key :feeling_type_mappings, :google_places_api_types, column: :google_places_api_type_id
  end
end
