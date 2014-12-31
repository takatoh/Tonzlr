class WallpapersController < ApplicationController
  before_action :set_wallpaper, only: [:show, :edit, :update, :destroy, :sample, :thumbnail]

  # GET /wallpapers
  # GET /wallpapers.json
  def index
    @wallpapers = Wallpaper.all
    @tags = Tag.all
    @tags_on_page = tags_on_page(@wallpapers)
    @total_images = Image.count
  end

  # GET /wallpapers/1
  # GET /wallpapers/1.json
  def show
    session[:wp_id] = @wallpaper.id
    @tags = @wallpaper.tags.sort_by{|t| t.name}
  end

  # GET /wallpapers/new
  def new
    @wallpaper = Wallpaper.new
  end

  # GET /wallpapers/1/edit
  def edit
  end

  # POST /wallpapers
  # POST /wallpapers.json
  def create
    @wallpaper = Wallpaper.new(wallpaper_params)
    @wallpaper.file = params["wallpaper"]["file"]
    @wallpaper.filename = params["wallpaper"]["file"].original_filename
    @wallpaper.tagname_string = params["wallpaper"]["tagname_string"]

    respond_to do |format|
      if @wallpaper.save
        format.html { redirect_to @wallpaper, notice: 'Wallpaper was successfully created.' }
        format.json { render :show, status: :created, location: @wallpaper }
      else
        format.html { render :new }
        format.json { render json: @wallpaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wallpapers/1
  # PATCH/PUT /wallpapers/1.json
  def update
    @wallpaper.tagname_string = params["wallpaper"]["tagname_string"]
    respond_to do |format|
      if @wallpaper.update(wallpaper_params)
        format.html { redirect_to @wallpaper, notice: 'Wallpaper was successfully updated.' }
        format.json { render :show, status: :ok, location: @wallpaper }
      else
        format.html { render :edit }
        format.json { render json: @wallpaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallpapers/1
  # DELETE /wallpapers/1.json
  def destroy
    @wallpaper.destroy
    respond_to do |format|
      format.html { redirect_to wallpapers_url, notice: 'Wallpaper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /wallpaper/sample/1
  def sample
    sample_path = "#{SITE_CONFIG['storage_dir']}/#{@wallpaper.sample_path}"
    send_file sample_path
  end

  # GET /wallpaper/thumbnail/1
  def thumbnail
    thumbnail_path = "#{SITE_CONFIG['storage_dir']}/#{@wallpaper.thumbnail_path}"
    send_file thumbnail_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallpaper
      @wallpaper = Wallpaper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wallpaper_params
      params.require(:wallpaper).permit(:title, :series, :creator, :source, :thumbnail_path, :sample_path)
    end

  def tags_on_page(wallpapers)
    tags = []
    for wp in wallpapers
      for tag in wp.tags
        tags << tag.name unless tags.include?(tag.name)
      end
    end
    tags
  end

end
