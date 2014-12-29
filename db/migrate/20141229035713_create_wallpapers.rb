class CreateWallpapers < ActiveRecord::Migration
  def change
    create_table :wallpapers do |t|
      t.string :title
      t.string :series
      t.string :creator
      t.stirng :source
      t.string :thumbnail_path
      t.stirng :sample_path

      t.timestamps
    end
  end
end
