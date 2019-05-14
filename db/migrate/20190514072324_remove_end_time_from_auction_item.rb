class RemoveEndTimeFromAuctionItem < ActiveRecord::Migration[5.2]
  def change
    remove_column :auction_items, :end_time, :string
  end
end
