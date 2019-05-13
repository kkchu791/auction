class AuctionItem < ApplicationRecord
  has_many :bids
  has_one :highest_bid, class_name: 'Bid', dependent: :destroy
  has_many :users, :through => :bids

  def place_bid!(user, points)
    validate_points(user, points)

    with_lock(true) do
      return_user_points

      new_bid = bids.create!({
        user: user,
        auction_item: self,
        points: points
      })
      update_attributes!(highest_bid: new_bid)

      user.subtract_points!(points)
    end
  end

  def return_user_points
    if highest_bid
      user = highest_bid.user
      user.add_points!(highest_bid.points)
    end
  end

  def validate_points(user, points)
    if user.points < points
      raise StandardError, "You don't have enough points to make that bid. Your current points is: #{user.points}"
    end

    if highest_bid.present? && (highest_bid.points >= points)
      raise StandardError, "#{points} is not greater than #{highest_bid.points}. You have to bid higher than the current bid points"
    end
  end
end
