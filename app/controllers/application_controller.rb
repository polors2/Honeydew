class ApplicationController < ActionController::Base
  helper_method :current_buyer, :current_seller, :buyer_logged_in?, :seller_logged_in?, :anyone_in?, :admin_logged_in?, :current_admin

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
    admin_logged_in? || buyer_logged_in? || seller_logged_in?
  end

  def require_seller
    if !seller_logged_in?
      redirect_to forbidden_url
    end
  end

  def require_buyer
    if !buyer_logged_in?
      redirect_to forbidden_url
    end
  end

  def require_admin
    if !admin_logged_in?
      redirect_to forbidden_url
    end
  end

  def only_seller
    if !seller_logged_in?
      redirect_to forbidden_url
    end
  end
  def only_buyer
    if !buyer_logged_in?
      redirect_to forbidden_url
    end
  end
  def only_admin
    if !admin_logged_in?
      redirect_to forbidden_url
    end
  end

  def buyer_or_admin
    if !admin_logged_in? && !buyer_logged_in?
      redirect_to forbidden_url
    end
  end
  def seller_or_admin
    if !admin_logged_in? && !seller_logged_in?
      redirect_to forbidden_url
    end
  end

  def require_logged_out
    if seller_logged_in?
        redirect_to seller_path(session[:seller_id])
    elsif
      buyer_logged_in?
        redirect_to buyer_path(session[:buyer_id])
    elsif admin_logged_in?
        redirect_to dashboard_path(session[:admin_id])
    end
  end

  def require_user
    if !anyone_in?
        flash[:danger] = 'You gotta login brah'
        redirect_to login_path
      end
  end
end
