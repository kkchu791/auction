class User < ApplicationRecord
  has_many :bids
  has_many :auction_items, :through => :bids
end
