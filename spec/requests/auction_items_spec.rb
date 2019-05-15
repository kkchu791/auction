require 'rails_helper'

describe "auction_items", type: :request do
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
end
