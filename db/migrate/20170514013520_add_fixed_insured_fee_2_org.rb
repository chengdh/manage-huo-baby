#coding: utf-8
class AddFixedInsuredFee2Org < ActiveRecord::Migration
  def up
    add_column :orgs,:fixed_insured_fee,:decimal,:precision => 15,:scale => 2,:default => 0
  end

  def down
  end
end
