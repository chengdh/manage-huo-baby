#coding: utf-8
class CreateVotableItems < ActiveRecord::Migration
  def change
    create_table :votable_items do |t|
      t.references :vote_config,:null => false
      t.string :name,:null => false,:limit => 20
      t.integer :order_by,:default => 0
      t.text :note

      t.timestamps
    end
  end
end
