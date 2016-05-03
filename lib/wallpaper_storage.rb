require 'fileutils'
require 'pathname'


class WallpaperStorage

  @@file_dir = "files"
  @@sample_dir = "samples"
  @@thumbnail_dir = "thumbs"
  @@sample_size = "800x800"
  @@thumbnail_size = "180x180"
  @@format = "jpg"


  def initialize(storage_dir)
    @storage_dir = Pathname.new(storage_dir)
    unless (@storage_dir + @@sample_dir).exist?
      FileUtils.mkdir_p(@storage_dir + @@sample_dir)
    end
    unless (@storage_dir + @@thumbnail_dir).exist?
      FileUtils.mkdir_p(@storage_dir + @@thumbnail_dir)
    end
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
    system("convert -scale #{@@sample_size} \"#{wp_path}\" #{sample_path}")
    system("convert -scale #{@@thumbnail_size} \"#{wp_path}\" #{thumbnail_path}")
    [sample_path.relative_path_from(@storage_dir).to_s,
     thumbnail_path.relative_path_from(@storage_dir).to_s]
  end

  def delete_image(path)
    path = @storage_dir + path
    FileUtils.rm(path)
    dir = path.parent
    if dir.children.empty?
      FileUtils.rmdir(dir)
    end
  end

  def delete_sample_and_thumbnail(wp_id)
    sample_path = @storage_dir + @@sample_dir + "#{wp_id.to_s}.#{@@format}"
    thumbnail_path = @storage_dir + @@thumbnail_dir + "#{wp_id.to_s}.#{@@format}"
    FileUtils.rm(sample_path)
    FileUtils.rm(thumbnail_path)
  end

end   # of WallpaperStorage
