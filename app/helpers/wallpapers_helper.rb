module WallpapersHelper

  def sample_path(wp)
    "/wallpapers/sample/#{wp.id.to_s}"
  end

  def thumbnail_path(wp)
    "/wallpapers/thumbnail/#{wp.id.to_s}"
  end

  def url_to_image(img)
    "/images/#{img.wallpaper_id.to_s}/#{File.basename(img.path)}"
  end

  def time_to_date(time)
    time.strftime("%Y-%m-%d")
  end

end
