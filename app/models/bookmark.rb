class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :destination
  validates_uniqueness_of :user_id, scope: :destination_id
end
