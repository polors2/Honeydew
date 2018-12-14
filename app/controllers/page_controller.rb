class PageController < ApplicationController
  before_action :require_logged_out, except: [:admin]
  before_action :require_admin, only: [:admin]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    redirect_to root_path
  end
  def index
    @sale = Sale.all
  end
end
