class Pool < ActiveRecord::Base

  has_many :poolings, :dependent => :destroy
  has_many :wallpapers, :through => :poolings

end
