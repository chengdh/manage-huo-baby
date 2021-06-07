class CreateGoodsCatPromotions < ActiveRecord::Migration
  def change
    create_table :goods_cat_promotions do |t|
      t.references :goods_cat,:null => false
      t.decimal :from_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :to_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :promotion_rate,:precision => 15,:scale => 3,:default => 0
      t.boolean :is_active,:default => true

      t.timestamps
    end
    add_index :goods_cat_promotions, :goods_cat_id
  end
end
