#coding: utf-8
class CreateVoteConfigs < ActiveRecord::Migration
  def change
    create_table :vote_configs do |t|
      t.string :name,:null => false
      t.string :mth,:null => false
      t.date :expire_date
      t.text :note

      t.timestamps
    end
  end
end
