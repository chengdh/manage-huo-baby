#coding: utf-8
class CreateScanHeaders < ActiveRecord::Migration
  def change
    create_table :scan_headers do |t|
      t.integer :from_org_id
      t.integer :to_org_id
      t.references :user
      t.string :type,:limit => 60
      t.date :bill_date
      t.text :note
      t.string :state,:limit => 60,:default => "draft"

      t.timestamps
    end
    add_index :scan_headers, :user_id
  end
end
