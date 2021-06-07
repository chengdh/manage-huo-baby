#coding: utf-8
#分理处分成明细
class CreateDivideListLines < ActiveRecord::Migration
  def change
    create_table :divide_list_lines do |t|
      t.references :divide_list,:null => false
      t.references :price_list_line,:null => false
      t.decimal :load_per_vehicle,:precision => 15,:scale => 2,:default => 0

      t.timestamps
    end
    add_index :divide_list_lines, :divide_list_id
    add_index :divide_list_lines, :price_list_line_id
  end
end
