#coding: utf-8
#实提运费统计表
class CreateCarryingFeeThRpts < ActiveRecord::Migration
  def change
    create_table :carrying_fee_th_rpts do |t|
      t.date :bill_date,:null => false
      t.integer :from_org_id,:null => false
      t.integer :to_org_id,:null => false
      t.decimal :carrying_fee,:scale => 2,:precision => 15,:default => 0

      t.timestamps
    end
    add_index :carrying_fee_th_rpts, :bill_date
    add_index :carrying_fee_th_rpts, :from_org_id
    add_index :carrying_fee_th_rpts, :to_org_id
  end
end
