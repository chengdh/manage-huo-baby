#coding: utf-8
#保证金
class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.references :org
      t.decimal :deposit_fee_1,:precision => 15,:scale => 2,:default => 0
      t.decimal :deposit_fee_2,:precision => 15,:scale => 2,:default => 0
      t.decimal :deposit_fee_3,:precision => 15,:scale => 2,:default => 0
      t.boolean :is_active,:default => true
      t.text :note
      t.references :user

      t.timestamps
    end
    add_index :deposits, :org_id
    add_index :deposits, :user_id
  end
end
