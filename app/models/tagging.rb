class Tagging < ActiveRecord::Base

  belongs_to :tag
  belongs_to :wallpaper, :foreign_key => :taggable_id

end
