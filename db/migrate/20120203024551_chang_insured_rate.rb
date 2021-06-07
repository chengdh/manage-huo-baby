# -*- encoding : utf-8 -*-
#coding: utf-8
class ChangInsuredRate < ActiveRecord::Migration
  def self.up
    change_column :carrying_bills,:insured_rate,:decimal,:default => 0,:precision => 10,:scale => 5
  end

  def self.down
  end
end

