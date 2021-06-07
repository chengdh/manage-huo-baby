# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateViewBills < ActiveRecord::Migration
  def self.up
    sql = <<-EOF
    CREATE OR REPLACE VIEW view_bills AS
      SELECT bill_no,goods_fee,state,from_customer_id FROM carrying_bills
    EOF
    execute sql
  end

  def self.down
  end
end

