class ApplicationController < ActionController::Base
  helper_method :current_buyer, :current_seller, :buyer_logged_in?, :seller_logged_in?, :anyone_in?, :admin_logged_in?

  def admin
    @buyers = Buyer.all
    @sellers = Seller.all
  end

  def current_buyer
    @current_buyer ||= Buyer.find(session[:buyer_id]) if session[:buyer_id]
  end

  def current_seller
    @current_seller ||= Seller.find(session[:seller_id]) if session[:seller_id]
  end

  def current_admin
    @current_admin ||=Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def admin_logged_in?
    !!current_admin
  end

  def buyer_logged_in?
    !!current_buyer
  end

  def seller_logged_in?
    !!current_seller
  end

  def anyone_in?
    !!current_seller && !!current_buyer && !!current_admin
  end

  def require_user
    if !anyone_in?
        flash[:danger] = 'You gotta login brah'
        redirect_to login_path
      end
  end
end
