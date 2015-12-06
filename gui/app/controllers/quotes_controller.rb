class QuotesController < ApplicationController
  def random
    @quote = Quote.random
    render :show
  end

  def show
    @quote = if params[:id].present?
      Quote.find params[:id]
    else
      Quote.get("quote/regex/#{URI.encode(params[:regex])}")
    end
    @quote ||= Quote.random
  end

  def by
    @quotes = Quote.get("quote/by/#{params[:person]}")
    render :index
  end
end
