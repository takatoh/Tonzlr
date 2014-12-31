module PoolsHelper

  def number_of_wallpapers(pool)
    pool.poolings_count
  end

  def number_of_images(pool)
    pool.wallpapers.map{|w| w.images_count }.sum
  end

end
