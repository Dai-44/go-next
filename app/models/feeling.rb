class Feeling < ApplicationRecord
  has_many :feeling_type_mappings, dependent: :destroy
  has_many :google_places_api_types, through: :feeling_type_mappings
end
