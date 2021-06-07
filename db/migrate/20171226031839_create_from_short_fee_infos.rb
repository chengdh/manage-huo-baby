#coding: utf-8
class CreateFromShortFeeInfos < ActiveRecord::Migration
  def change
    create_table :from_short_fee_infos do |t|
      t.date :bill_date
      t.references :user
      t.integer :from_org_id,:null => false
      t.integer :to_org_id,:null => false
      t.string :state,:null => false,:limit => 60,:default => "draft"
      t.text :note
      t.integer :audit_user_id
      t.datetime :audit_date

      t.timestamps
    end
    add_index :from_short_fee_infos, :user_id
  end
end
