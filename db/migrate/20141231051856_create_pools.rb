class CreatePools < ActiveRecord::Migration
  def change
    create_table :pools do |t|
      t.string :name
      t.string :description
      t.integer :poolings_count, :default => 0
      t.boolean :closed, :default => false, :null => false

      t.timestamps
    end
  end
end
