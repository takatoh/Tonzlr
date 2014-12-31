class Wallpaper < ActiveRecord::Base

  has_many :images, :dependent => :destroy
  has_many :taggings, :dependent => :destroy, :foreign_key => :taggable_id
  has_many :tags, :through => :taggings


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


  before_create do |wp|
    image = Image.new
    image.wallpaper_id = wp.id
    image.file = wp.file
    image.filename = wp.filename
    wp.images << image
  end

  after_create do |wp|
    storage = WallpaperStorage.new(SITE_CONFIG["storage_dir"])
    sample_path, thumbnail_path = storage.make_sample_and_thumbnail(wp.id, wp.filename)
    wp.update_attributes(sample_path: sample_path)
    wp.update_attributes(thumbnail_path: thumbnail_path)
  end

  after_destroy do |wp|
    storage = WallpaperStorage.new(SITE_CONFIG["storage_dir"])
    storage.delete_sample_and_thumbnail(wp.id)
  end

end
