class User < ApplicationRecord
  has_many :bids
  has_many :auction_items, :through => :bids
  has_secure_password
  validates_uniqueness_of :email

  def add_points!(new_points)
    #reload is neccessary because we want to update the points with the latest value
    update_attributes!(points: reload.points + new_points)
  end

  def subtract_points!(used_points)
    #reload is neccessary because we want to update the points with the latest value
    update_attributes!(points: reload.points - used_points)
  end
end
