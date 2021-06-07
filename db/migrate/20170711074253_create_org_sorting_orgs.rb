#coding: utf-8
class CreateOrgSortingOrgs < ActiveRecord::Migration
  def change
    create_table :org_sorting_orgs do |t|
      t.references :org_sorting
      t.references :org

      t.timestamps
    end
    add_index :org_sorting_orgs, :org_sorting_id
    add_index :org_sorting_orgs, :org_id
  end
end
