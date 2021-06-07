#coding: utf-8
class AddAutoGenerateFromShortCarryingFeeToOrg < ActiveRecord::Migration
  def change
    add_column :orgs, :auto_generate_from_short_carrying_fee, :boolean,:default => false
    add_column :orgs, :agfscf_rate, :decimal,:precision => 15,:scale => 2,:default => 0
    add_column :orgs, :fixed_from_short_carrying_fee, :decimal,:precision => 15,:scale => 2,:default => 0

  end
end
