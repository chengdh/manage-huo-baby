#coding: utf-8
class CreateScanLines < ActiveRecord::Migration
  def change
    create_table :scan_lines do |t|
      t.references :scan_header
      t.references :carrying_bill
      t.integer :from_org_id
      t.integer :to_org_id
      t.integer :qty

      t.timestamps
    end
    add_index :scan_lines, :scan_header_id
    add_index :scan_lines, :carrying_bill_id
  end
end
