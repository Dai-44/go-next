class GooglePlacesApiType < ApplicationRecord
  has_many :feeling_type_mappings
  has_many :feelings, through: :feeling_type_mappings
end
