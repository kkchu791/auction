class User < ApplicationRecord
  has_many :bids
  has_many :auction_items, :through => :bids
  validates_uniqueness_of :email
  has_secure_password
  after_create :generate_inital_points

  def generate_inital_points
    #all users will start out with these amount of points
    update_attributes!(points: 500)
  end

  def add_points!(new_points)
    #reload is neccessary because we want to update the points with the latest value
    update_attributes!(points: reload.points + new_points)
  end

  def subtract_points!(used_points)
    #reload is neccessary because we want to update the points with the latest value
    update_attributes!(points: reload.points - used_points)
  end
end
