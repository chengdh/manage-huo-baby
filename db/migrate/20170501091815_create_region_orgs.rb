class CreateRegionOrgs < ActiveRecord::Migration
  def change
    create_table :region_orgs do |t|
      t.references :region
      t.references :org

      t.timestamps
    end
    add_index :region_orgs, :region_id
    add_index :region_orgs, :org_id
  end
end
