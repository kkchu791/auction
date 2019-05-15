require 'rails_helper'

describe User do
  # all users will start with 500 points
  let(:user) { User.create(email: "test@gmail.com", password: "Password1!") }

  describe "#add_points!" do
    it "should add points to the users previous point amount" do
      user_new_point_total = 700
      user.add_points!(200)
      expect(user.points).to eq(user_new_point_total)
    end
  end

  describe "#subtract_points!" do
    it "should subtract points from the users previous point amount" do
      user_new_point_total = 300
      user.subtract_points!(200)
      expect(user.points).to eq(user_new_point_total)
    end
  end
end
