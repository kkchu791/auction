class AuctionItemsController < ApplicationController
  def index
    @auction_items = AuctionItem.all
  end
end
