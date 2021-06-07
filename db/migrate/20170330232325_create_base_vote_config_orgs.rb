#coding: utf-8
class CreateBaseVoteConfigOrgs < ActiveRecord::Migration
  def change
    create_table :base_vote_config_orgs do |t|
      t.references :base_vote_config,:null => false
      t.references :org,:null => false

      t.timestamps
    end
    add_index :base_vote_config_orgs, :base_vote_config_id
    add_index :base_vote_config_orgs, :org_id
  end
end
