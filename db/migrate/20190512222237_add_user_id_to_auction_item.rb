class AddUserIdToAuctionItem < ActiveRecord::Migration[5.2]
  def change
    add_column :auction_items, :user_id, :integer
  end
end
