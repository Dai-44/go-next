class GooglePlacesApiType < ApplicationRecord
  has_many :feeling_type_mappings, dependent: :destroy
  has_many :feelings, through: :feeling_type_mappings
  has_many :destinations

  scope :by_feeling, lambda { |feeling_id|
    joins(:feeling_type_mappings)
      .where(feeling_type_mappings: { feeling_id: feeling_id })
  }
end
