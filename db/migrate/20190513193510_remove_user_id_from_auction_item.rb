class RemoveUserIdFromAuctionItem < ActiveRecord::Migration[5.2]
  def change
    remove_column :auction_items, :user_id, :string
  end
end
