class CreateAuctionItems < ActiveRecord::Migration[5.2]
  def change
    create_table :auction_items do |t|
      t.string :name
      t.string :image
      t.integer :highest_bid
      t.datetime :end_time

      t.timestamps
    end
  end
end
