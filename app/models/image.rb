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

  before_create do |row|
    storage = WallpaperStorage.new("./storage")
    f = row.file
    if row[:width].blank?
      row[:width] = `identify -format %[width] #{f}`.to_i
      row[:height] = `identify -format %[height] #{f}`.to_i
    end
    row[:path] = storage.store_wallpaper(row.wallpaper_id, f, row.filename)
  end


end
