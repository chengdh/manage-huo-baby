#coding: utf-8
class CreateVotableItemOrgs < ActiveRecord::Migration
  def change
    create_table :votable_item_orgs do |t|
      t.references :votable_item
      t.references :org
      t.boolean :selected

      t.timestamps
    end
    add_index :votable_item_orgs, :votable_item_id
    add_index :votable_item_orgs, :org_id
    add_index :votable_item_orgs, :selected
  end
end
