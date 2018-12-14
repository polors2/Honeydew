class PageController < ApplicationController
  before_action :require_logged_out, except: [:admin]
  def index
    @sale = Sale.all
  end
end
