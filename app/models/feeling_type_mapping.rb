class FeelingTypeMapping < ApplicationRecord
  belongs_to :feeling
  belongs_to :google_places_api_type
end
