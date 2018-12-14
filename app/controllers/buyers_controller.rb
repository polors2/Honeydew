class BuyersController < ApplicationController
  before_action :set_buyer, only: [:show, :edit, :update, :destroy]
  before_action :require_user
  before_action :buyer_logged_in?

  # GET /buyers
  # GET /buyers.json
  def index
    @buyers = Buyer.all
  end

  # GET /buyers/1
  # GET /buyers/1.json
  def show
    @sale = Sale.all
  end

  # GET /buyers/new
  def new
    @buyer = Buyer.new
  end

  # GET /buyers/1/edit
  def edit
  end

  def buy
    @sale = Sale.find(params[:id])
    @sale.buyer_id = session[:buyer_id]
    redirect_to buyer_path(session[:buyer_id])
  end

  # POST /buyers
  # POST /buyers.json
  def create
    @buyer = Buyer.new(buyer_params)

    respond_to do |format|
      if @buyer.save
        format.html { redirect_to @buyer, notice: 'Buyer was successfully created.' }
        format.json { render :show, status: :created, location: @buyer }
      else
        format.html { render :new }
        format.json { render json: @buyer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buyers/1
  # PATCH/PUT /buyers/1.json
  def update
    respond_to do |format|
      if @buyer.update(buyer_params)
        format.html { redirect_to @buyer, notice: 'Buyer was successfully updated.' }
        format.json { render :show, status: :ok, location: @buyer }
      else
        format.html { render :edit }
        format.json { render json: @buyer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buyers/1
  # DELETE /buyers/1.json
  def destroy
    @buyer.destroy
    respond_to do |format|
      format.html { redirect_to buyers_url, notice: 'Buyer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buyer
      @buyer = Buyer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buyer_params
      params.require(:buyer).permit(:first_name,:last_name, :email, :password,:birthday)
    end

    def sale_params
      params.require(:sale).permit(:seller_id, :product_id, :price, :buyer_id)
    end
end
