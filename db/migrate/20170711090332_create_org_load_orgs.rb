#coding: utf-8
class CreateOrgLoadOrgs < ActiveRecord::Migration
  def change
    create_table :org_load_orgs do |t|
      t.references :org_load
      t.references :org
      t.boolean :is_select,:default => false

      t.timestamps
    end
    add_index :org_load_orgs, :org_load_id
    add_index :org_load_orgs, :org_id
  end
end
