
#coding: utf-8
class CreateFromShortFeeLines < ActiveRecord::Migration
  def change
    create_table :from_short_fee_lines do |t|
      t.references :from_short_fee_info,:null => false
      t.references :carrying_bill,:null => false


      t.timestamps
    end
    add_index :from_short_fee_lines, :from_short_fee_info_id
    add_index :from_short_fee_lines, :carrying_bill_id
  end
end
