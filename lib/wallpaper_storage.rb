require 'fileutils'
require 'pathname'


class WallpaperStorage

  @@file_dir = "files"
  @@sample_dir = "samples"
  @@thumbnail_dir = "thumbs"


  def initialize(storage_dir)
    @storage_dir = Pathname.new(storage_dir)
  end

  def store_wallpaper(wp_id, file, file_name)
    wp_path = @storage_dir + @@file_dir + wp_id.to_s + file_name
    FileUtils.mkdir_p(wp_path.parent)
    FileUtils.cp(file.path, wp_path)
    wp_path.to_s
  end

end   # of WallpaperStorage
