class PageController < ApplicationController
  before_action :require_logged_out
  def index
    @sale = Sale.all
  end
end
