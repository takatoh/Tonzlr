class Wallpaper < ActiveRecord::Base

  has_many :images, :dependent => :destroy

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

end
