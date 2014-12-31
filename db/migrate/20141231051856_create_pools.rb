class CreatePools < ActiveRecord::Migration
  def change
    create_table :pools do |t|
      t.string :name
      t.string :description
      t.integer :poolings_count
      t.boolean :closed

      t.timestamps
    end
  end
end
