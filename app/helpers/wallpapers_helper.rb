module WallpapersHelper

  def sample_path(wp)
    "/wallpapers/sample/#{wp.id.to_s}"
  end

  def thumbnail_path(wp)
    "/wallpapers/thumbnail/#{wp.id.to_s}"
  end

  def url_to_image(img)
    "/images/file/#{img.id.to_s}"
  end

  def time_to_date(time)
    time.strftime("%Y-%m-%d")
  end

  def num_of_tagname(tagname)
    @tags.select{|t| t.name == tagname}.first.taggings.size
  end

end
