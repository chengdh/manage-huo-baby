#coding: utf-8
#短驳单
class CreateShortLists < ActiveRecord::Migration
  def change
    create_table :short_lists do |t|
      t.date :bill_date
      t.string :bill_no
      t.string :vehicle_no
      t.string :driver
      t.string :mobile
      t.integer :from_org_id,:null => false
      t.integer :to_org_id,:null => false
      t.text :note
      t.string :state,:default => 'draft'
      t.references :user

      t.timestamps
    end
    add_index :short_lists, :from_org_id
    add_index :short_lists, :to_org_id
    add_index :short_lists, :user_id
  end
end