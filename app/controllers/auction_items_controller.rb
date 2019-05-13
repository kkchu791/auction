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

  def place_bid
    @auction_item = AuctionItem.find(params[:id])
    begin
      @auction_item.place_bid!(current_user, auction_item_params[:highest_bid].to_i)
      render 'success'
    rescue StandardError => e
      @errors = @auction_item.errors.full_messages
      @errors << e.to_s
      render 'edit'
    end
  end

  private

  def auction_item_params
    params.require(:auction_item).permit(:highest_bid)
  end
end
