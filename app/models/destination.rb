class Destination < ApplicationRecord
  belongs_to :google_places_api_type
  has_many :drive_records
  has_many :bookmarks

  def self.get_unique_areas
    select(:area).distinct.order(area: :asc).pluck(:area)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(area)
  end

  def self.ransackable_associations(auth_object = nil)
    %w(google_places_api_type)
  end
end
