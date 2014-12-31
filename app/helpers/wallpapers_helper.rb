module WallpapersHelper

  def thumbnail_path(wp)
    "/wallpapers/thumbnail/#{wp.id.to_s}"
  end

end
