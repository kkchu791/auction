require 'rails_helper'

describe "auction_items", type: :request do

  let(:user) { User.create(email: "test@gmail.com", password: "Password1!") }
  let(:auction_item) { AuctionItem.create(name: "Fan") }

  describe "GET /auction_items" do
    it "should have an endpoint" do
      get '/auction_items'
      expect(response).to have_http_status(200)
    end

    it "should render index template" do
      get '/auction_items'
      expect(response).to render_template(:index)
    end
  end

  describe "SHOW /auction_items/:id" do
    it "should have an endpoint" do
      get "/auction_items/#{auction_item.id}"
      expect(response).to have_http_status(200)
    end

    it "should render show template" do
      get '/auction_items'
      expect(response).to render_template(:show)
    end
  end

  describe "PATCH /place_bid/:id" do
    it "should have an endpoint" do
      patch "/auction_items/#{auction_item.id}"
      expect(response).to have_http_status(200)
    end

    it "should render show template" do
      get '/'
      expect(response).to render_template(:show)
    end
  end
end
