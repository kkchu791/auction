require "rails_helper"

describe AuctionItem do
  # all users will start with 500 points
  let(:user) { User.create(email: "test@gmail.com", password: "Password1!") }
  let(:user2) { User.create(email: "test2@gmail.com", password: "Password1!") }
  let(:auction_item) { AuctionItem.create(name: "Fan") }

  describe "#place_bid!" do
    before do
      current_highest_bid = auction_item.bids.create(user_id: user.id, points: 100)
      auction_item.place_bid!(user2, 200)
    end

    it "should create a new bid" do
      expect { auction_item.place_bid!(user, 300) }.to change{ Bid.count }.by(1)
    end

    it "should return previous higher bidders points" do
      expect(user.reload.points).to eq(600)
    end

    it "should create a new highest bid for auction item" do
      expect(auction_item.highest_bid.points).to eq(200)
      expect(auction_item.highest_bid.user).to eq(user2)
    end

    it "should subtract points from current highest bidder" do
      expect(user2.reload.points).to eq(300)
    end

    context "when user bids lower than current bid" do
      it "should raise an error" do
        error_msg = "100 is not greater than 200. You have to bid higher than the current bid points."
        expect{auction_item.place_bid!(user2, 100)}.to raise_error(error_msg)
      end
    end

    context "when user has insufficient points to make a bid" do
      it "should raise an error" do
        expect(user.reload.points).to eq(600)
        expect{auction_item.place_bid!(user, 700)}.to raise_error("You don't have enough points to make that bid. Your current points is: 600")
      end
    end

    context "when an error occurs within the lock transaction" do
      before do
        current_highest_bid = auction_item.bids.create(user_id: user.id, points: 100)
        allow(user2).to receive(:subtract_points!).and_raise("oops")
      end

      def place_bid!(user, points)
        auction_item.place_bid!(user, points) rescue nil
      end

      it "should not return the current highest bidder's points" do
        expect{ place_bid!(user2, 200) }.to_not change{ user.points }
      end

      it "should not create a new highest bid for auction item" do
        expect{ place_bid!(user2, 200) }.to_not change{ auction_item.reload.highest_bid }
      end

      it "should not deduct points from current bidder" do
        expect{  place_bid!(user2, 200) }.to_not change{ user2.points }
      end
    end
  end
end
