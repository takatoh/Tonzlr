class AddImagesCountToWallpapers < ActiveRecord::Migration
  def change
    add_column :wallpapers, :images_count, :integer, :default => 0
  end
end
