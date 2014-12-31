class Wallpaper < ActiveRecord::Base

  has_many :images, :dependent => :destroy
  has_many :taggings, :dependent => :destroy, :foreign_key => :taggable_id
  has_many :tags, :through => :taggings
  has_many :poolings, :dependent => :destroy
  has_many :pools, :through => :poolings


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

  def tagname_string
    @tagname_string
  end

  def tagname_string=(str)
    @tagname_string = str
  end

  def tags_string
    tags.map{|t| t.name}.join(" ")
  end

  def add_tag(tagname)
    tag = Tag.where('name = ?', tagname).first || Tag.create(:name => tagname)
    unless tags.map{|t| t.name}.include?(tag.name)
      tagging = Tagging.create(:tag_id => tag.id, :taggable_id => self.id, :taggable_type => "Wallpaper")
      taggings << tagging
      tag.taggings << tagging
      tag
    else
      nil
    end
  end

  def add_tags(tagname_string)
    return nil if tagname_string.nil? || /\A *\z/ =~ tagname_string
    tagnames = tagname_string.split(/ +/)
    tagnames.map{|tag| add_tag(tag)}.compact
  end

  def delete_tag(tagname)
    tagging = taggings.select{|t| t.tag.name == tagname}.first
    if tagging
      tagging.delete
      tagname
    else
      nil
    end
  end

  def update_tags(tagname_string)
    return nil if tagname_string.nil? || /\A *\z/ =~ tagname_string
    tagnames = tagname_string.strip.split(/ +/)
    tagnames0 = tags.map{|t| t.name}
    (tagnames - tagnames0).each{|t| add_tag(t)}
    (tagnames0 - tagnames).each{|t| delete_tag(t)}
    tagnames
  end


  before_create do |wp|
    image = Image.new
    image.wallpaper_id = wp.id
    image.file = wp.file
    image.filename = wp.filename
    wp.images << image
    wp.add_tags(wp.tagname_string)
  end

  after_create do |wp|
    wp.reload
    storage = WallpaperStorage.new(SITE_CONFIG["storage_dir"])
    sample_path, thumbnail_path = storage.make_sample_and_thumbnail(wp.id, wp.filename)
    wp.update_attributes(sample_path: sample_path)
    wp.update_attributes(thumbnail_path: thumbnail_path)
  end

  after_update do |wp|
    wp.update_tags(wp.tagname_string)
  end

  after_destroy do |wp|
    storage = WallpaperStorage.new(SITE_CONFIG["storage_dir"])
    storage.delete_sample_and_thumbnail(wp.id)
  end

end
