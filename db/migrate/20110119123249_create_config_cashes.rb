# -*- encoding : utf-8 -*-
#coding: utf-8
#代收货款,现金费用设置
class CreateConfigCashes < ActiveRecord::Migration
  def self.up
    create_table :config_cashes do |t|
      t.decimal :fee_from,:precision => 15,:scale => 2,:default => 0
      t.decimal :fee_to,:precision => 15,:scale => 2,:default => 0
      t.decimal :hand_fee,:precision => 15,:scale => 2,:default => 0
      t.boolean :is_active,:null => false,:default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :config_cashes
  end
end
