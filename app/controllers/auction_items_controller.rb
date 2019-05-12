class AuctionItemsController < ApplicationController
  def index
    @auction_items = AuctionItem.all
  end

  def show
    @auction_item = AuctionItem.find(params[:id])
  end

  def edit
    @auction_item = AuctionItem.find(params[:id])
  end

  def update
    @auction_item = AuctionItem.find(params[:id])
    if @auction_item.update_attributes(auction_item_params)
      render 'success'
    else
      render 'edit'
    end
  end


  private

  def auction_item_params
    params.require(:auction_item).permit(:highest_bid)
  end
end
