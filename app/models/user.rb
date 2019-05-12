class User < ApplicationRecord
  has_many :bids
  has_many :auction_items, :through => :bids
  has_secure_password
  validates_uniqueness_of :email
end
