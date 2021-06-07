class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name,:limit => 60,:null => false
      t.string :note
      t.boolean :is_active,:default => true

      t.timestamps
    end
  end
end
