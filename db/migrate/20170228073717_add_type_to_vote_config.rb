#coding: utf-8
class AddTypeToVoteConfig < ActiveRecord::Migration
  def change
    add_column :vote_configs,:type,:string,:limit => 60
  end
end
