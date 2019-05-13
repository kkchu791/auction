class RemoveHighestBidFromAuctionItem < ActiveRecord::Migration[5.2]
  def change
    remove_column :auction_items, :highest_bid, :integer
  end
end
