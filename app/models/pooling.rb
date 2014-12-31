class Pooling < ActiveRecord::Base

  belongs_to :pool, :counter_cache => true
  belongs_to :wallpaper

end
