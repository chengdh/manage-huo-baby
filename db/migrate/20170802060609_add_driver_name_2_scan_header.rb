#coding: utf-8
class AddDriverName2ScanHeader < ActiveRecord::Migration
  def up
    add_column :scan_headers,:driver_name,:string,:limit => 30
    add_column :scan_headers,:v_no,:string,:limit => 30
    add_column :scan_headers,:mobile,:string,:limit => 30
    add_column :scan_headers,:id_no,:string,:limit => 30
  end

  def down
  end
end
