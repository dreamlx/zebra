class StoreAssistantsController < ApplicationController
  before_action :set_store_assistant, only: [:show, :edit, :update, :destroy]

  # GET /store_assistants
  # GET /store_assistants.json
  def index
    @store_assistants = StoreAssistant.all
  end

  # GET /store_assistants/1
  # GET /store_assistants/1.json
  def show
  end

  # GET /store_assistants/new
  def new
    @store_assistant = StoreAssistant.new
  end

  # GET /store_assistants/1/edit
  def edit
  end

  # POST /store_assistants
  # POST /store_assistants.json
  def create
    @store_assistant = StoreAssistant.new(store_assistant_params)

    respond_to do |format|
      if @store_assistant.save
        format.html { redirect_to @store_assistant, notice: 'Store assistant was successfully created.' }
        format.json { render :show, status: :created, location: @store_assistant }
      else
        format.html { render :new }
        format.json { render json: @store_assistant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /store_assistants/1
  # PATCH/PUT /store_assistants/1.json
  def update
    respond_to do |format|
      if @store_assistant.update(store_assistant_params)
        format.html { redirect_to @store_assistant, notice: 'Store assistant was successfully updated.' }
        format.json { render :show, status: :ok, location: @store_assistant }
      else
        format.html { render :edit }
        format.json { render json: @store_assistant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store_assistants/1
  # DELETE /store_assistants/1.json
  def destroy
    @store_assistant.destroy
    respond_to do |format|
      format.html { redirect_to store_assistants_url, notice: 'Store assistant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_assistant
      @store_assistant = StoreAssistant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_assistant_params
      params.require(:store_assistant).permit(:openid, :cell, :name, :score, :image, :birthday, :level)
    end
end
