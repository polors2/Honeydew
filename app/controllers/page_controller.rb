class PageController < ApplicationController
  def index
    @sale = Sale.all
  end
end
