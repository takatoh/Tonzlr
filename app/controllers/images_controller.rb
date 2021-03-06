require 'mime/types'

class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy, :file]
  protect_from_forgery :except => ["create"]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
    @image.wallpaper_id = session[:wp_id]
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    @image.file = params["image"]["file"]
    @image.filename = params["image"]["file"].original_filename

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image.wallpaper, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def file
    # image = Image.find(params[:id])
    file = "#{SITE_CONFIG['storage_dir']}/#{@image.path}"
    filename = File.basename(file)
    mimetype = MIME::Types.type_for(file)[0].to_s
    send_file file, :type => mimetype, :filename => filename
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:wallpaper_id, :width, :height, :path)
    end
end
