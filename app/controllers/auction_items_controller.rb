class AuctionItemsController < ApplicationController
  before_action :authorize, except: [:index]

  def index
    @auction_items = AuctionItem.all
  end

  def show
    @auction_item = AuctionItem.find(params[:id])
  end

  def edit
    @auction_item = AuctionItem.find(params[:id])
  end

  def place_bid
    @auction_item = AuctionItem.find(params[:id])
    begin
      points =  item_params[:points].to_i
      @auction_item.place_bid!(current_user, points)
      render 'success'
    rescue => e
      @errors = [e.to_s]
      render 'edit'
    end
  end

  private

  def item_params
    params.permit(:points)
  end
end


# if place bid doesn't raises an errors i get  200 message
# if place bid  raises and error

  # hitting the place bid action,  expect(auction_item)to recieve(place_bid).with(current_user, highest_bid params)

  # place in controller specs

  #before do
    #login current_user
  #end
