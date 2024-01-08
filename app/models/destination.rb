class Destination < ApplicationRecord
  belongs_to :google_places_api_type, optional: true
end
