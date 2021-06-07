class AddRateToConfigCash < ActiveRecord::Migration
  def self.up
    add_column :config_cashes, :rate, :decimal,:precision => 10,:scale => 4,:default => 0.001
  end

  def self.down
    remove_column :config_cashes, :rate
  end
end
