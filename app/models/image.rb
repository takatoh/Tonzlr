class Image < ActiveRecord::Base

  belongs_to :wallpaper


  def file=(file)
    @file = file
  end

  def file
    @file
  end

  def filename=(filename)
    @filename = filename
  end

  def filename
    @filename
  end

  def size_string
    "#{width.to_s}x#{height.to_s}"
  end


  before_create do |row|
    storage = WallpaperStorage.new("./storage")
    f = row.file
    row[:width] = `identify -format %[width] #{f.path}`.to_i
    row[:height] = `identify -format %[height] #{f.path}`.to_i
    row[:path] = storage.store_wallpaper(row.wallpaper_id, f, row.filename)
  end

  after_destroy do |img|
    storage = WallpaperStorage.new("./storage")
    storage.delete_image(img.path)
  end

end
