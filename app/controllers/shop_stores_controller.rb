class ShopStoresController < ApplicationController
  before_action :set_shop_store, only: [:show, :edit, :update, :destroy]

  # GET /shop_stores
  # GET /shop_stores.json
  def index
    @shop_stores = ShopStore.all
  end

  # GET /shop_stores/1
  # GET /shop_stores/1.json
  def show
  end

  # GET /shop_stores/new
  def new
    @shop_store = ShopStore.new
  end

  # GET /shop_stores/1/edit
  def edit
  end

  # POST /shop_stores
  # POST /shop_stores.json
  def create
    @shop_store = ShopStore.new(shop_store_params)

    respond_to do |format|
      if @shop_store.save
        format.html { redirect_to @shop_store, notice: 'Shop store was successfully created.' }
        format.json { render :show, status: :created, location: @shop_store }
      else
        format.html { render :new }
        format.json { render json: @shop_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop_stores/1
  # PATCH/PUT /shop_stores/1.json
  def update
    respond_to do |format|
      if @shop_store.update(shop_store_params)
        format.html { redirect_to @shop_store, notice: 'Shop store was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop_store }
      else
        format.html { render :edit }
        format.json { render json: @shop_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop_stores/1
  # DELETE /shop_stores/1.json
  def destroy
    @shop_store.destroy
    respond_to do |format|
      format.html { redirect_to shop_stores_url, notice: 'Shop store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop_store
      @shop_store = ShopStore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_store_params
      params.require(:shop_store).permit(:tile, :code, :contact, :mobile, :address)
    end
end
