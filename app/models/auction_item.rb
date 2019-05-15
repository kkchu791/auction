class AuctionItem < ApplicationRecord
  has_many :bids
  has_many :users, through: :bids

  def place_bid!(user, points)
    validate_points(user, points)

    with_lock(true) do
      return_highest_bidder_points

      bids.create!({
        user: user,
        points: points
      })

      user.subtract_points!(points)
    end
  end

  def highest_bid
    bids.order(created_at: :desc).first
  end

  private

  def return_highest_bidder_points
    if highest_bid
      previous_highest_bidder = highest_bid.user
      previous_highest_bidder.add_points!(highest_bid.points)
    end
  end

  def validate_points(user, points)
    validates_user_has_enough_points(user, points)
    validates_users_bid_high_enough(user, points)
  end

  def validates_user_has_enough_points(user, points)
    if user.points < points
      raise "You don't have enough points to make that bid. Your current points is: #{user.points}"
    end
  end

  def validates_users_bid_high_enough(user, points)
    if highest_bid && highest_bid.points >= points
      raise "#{points} is not greater than #{highest_bid.points}. You have to bid higher than the current bid points."
    end
  end
end
