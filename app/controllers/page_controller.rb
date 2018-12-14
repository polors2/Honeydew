class PageController < ApplicationController
  before_action :require_logged_out, except: [:admin]
  before_action :require_user, only: [:admin]
  def index
    @sale = Sale.all
  end
end
