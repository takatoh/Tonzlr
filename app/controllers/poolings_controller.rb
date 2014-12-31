class PoolingsController < ApplicationController
  before_action :set_pooling, only: [:show, :edit, :update, :destroy]

  # GET /poolings
  # GET /poolings.json
  def index
    @poolings = Pooling.all
  end

  # GET /poolings/1
  # GET /poolings/1.json
  def show
  end

  # GET /poolings/new
  def new
    @pooling = Pooling.new
    @pooling.wallpaper_id = session[:wp_id]
    @pools = Pool.order(:name).where('closed = ?', false)
  end

  # GET /poolings/1/edit
  def edit
  end

  # POST /poolings
  # POST /poolings.json
  def create
    @pooling = Pooling.new(pooling_params)

    respond_to do |format|
      if @pooling.save
        format.html { redirect_to @pooling, notice: 'Pooling was successfully created.' }
        format.json { render :show, status: :created, location: @pooling }
      else
        format.html { render :new }
        format.json { render json: @pooling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /poolings/1
  # PATCH/PUT /poolings/1.json
  def update
    respond_to do |format|
      if @pooling.update(pooling_params)
        format.html { redirect_to @pooling, notice: 'Pooling was successfully updated.' }
        format.json { render :show, status: :ok, location: @pooling }
      else
        format.html { render :edit }
        format.json { render json: @pooling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poolings/1
  # DELETE /poolings/1.json
  def destroy
    @pooling.destroy
    respond_to do |format|
      format.html { redirect_to poolings_url, notice: 'Pooling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pooling
      @pooling = Pooling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pooling_params
      params.require(:pooling).permit(:pool_id, :wallpaper_id)
    end
end
