class Destination < ApplicationRecord
  belongs_to :google_places_api_type, optional: true
  has_many :drive_records
  has_many :bookmarks
end
