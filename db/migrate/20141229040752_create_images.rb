class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :wallpaper_id
      t.integer :width
      t.integer :height
      t.string :path

      t.timestamps
    end
  end
end
