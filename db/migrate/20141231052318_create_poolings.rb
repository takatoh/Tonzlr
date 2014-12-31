class CreatePoolings < ActiveRecord::Migration
  def change
    create_table :poolings do |t|
      t.integer :pool_id
      t.integer :wallpaper_id

      t.timestamps
    end
  end
end
