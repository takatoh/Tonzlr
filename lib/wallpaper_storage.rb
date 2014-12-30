require 'fileutils'
require 'pathname'


class WallpaperStorage

  @@file_dir = "files"
  @@sample_dir = "samples"
  @@thumbnail_dir = "thumbs"
  @@format = "jpg"


  def initialize(storage_dir)
    @storage_dir = Pathname.new(storage_dir)
  end

  def store_wallpaper(wp_id, file, file_name)
    wp_path = @storage_dir + @@file_dir + wp_id.to_s + file_name
    FileUtils.mkdir_p(wp_path.parent)
    FileUtils.cp(file.path, wp_path)
    wp_path.relative_path_from(@storage_dir).to_s
  end

  def make_sample_and_thumbnail(wp_id, filename)
    wp_path = @storage_dir + @@file_dir + wp_id.to_s + filename
    sample_path = @storage_dir + @@sample_dir + "#{wp_id.to_s}.#{@@format}"
    thumbnail_path = @storage_dir + @@thumbnail_dir + "#{wp_id.to_s}.#{@@format}"
    [sample_path.relative_path_from(@storage_dir).to_s,
     thumbnail_path.relative_path_from(@storage_dir).to_s]
  end

end   # of WallpaperStorage
