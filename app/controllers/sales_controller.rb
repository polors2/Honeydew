class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]
  before_action :require_user
  before_action :seller_or_admin, only: [:index]
  before_action :require_same_user, only: [:edit, :update, :delete, :show]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    redirect_to dashboard_path(session[:admin_id])
  end

  def require_same_user
    if seller_logged_in?
    @curuser = Seller.find(session[:seller_id])

    if session[:seller_id] != @sale.seller_id && !admin_logged_in?
      redirect_to sellers_path(session[:seller_id])
    end
  end
    if buyer_logged_in?
      @curuser = Buyer.find(session[:buyer_id])

    if session[:buyer_id] != @sale.buyer_id && !admin_logged_in?
      redirect_to buyers_path(session[:buyer_id])
    end
    end
end

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)
    @sale.seller_id = session[:seller_id]

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    #if seller nakalogin
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    # else if buyer nakalogin
      #@sale.buyer_id = session[id]
      #if @sale.save
        #etc
      #end
    #end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:product_id, :price, :buyer_id)
    end
end
