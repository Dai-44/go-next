class DriveRecord < ApplicationRecord
  belongs_to :user
  belongs_to :destination

  def self.get_unique_visited_months
    select(:visited_month).distinct.order(visited_month: :asc).pluck(:visited_month)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(visited_month)
  end

  def self.ransackable_associations(auth_object = nil)
    %w(destination)
  end
end
