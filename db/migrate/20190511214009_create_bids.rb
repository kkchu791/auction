class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.integer :user_id
      t.integer :auction_item_id
      t.integer :points

      t.timestamps
    end
  end
end
