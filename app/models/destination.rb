class Destination < ApplicationRecord
  belongs_to :google_type, class_name: 'GooglePlacesApiType', optional: true # 関連名が長いと可読性さがるため、エイリアスを設定
  has_many :drive_records
  has_many :bookmarks

  def self.get_unique_areas
    select(:area).distinct.order(area: :asc).pluck(:area)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(area)
  end

  def self.ransackable_associations(auth_object = nil)
    %w(google_type)
  end
end
