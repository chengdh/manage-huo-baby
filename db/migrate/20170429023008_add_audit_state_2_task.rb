#coding: utf-8
class AddAuditState2Task < ActiveRecord::Migration
  def up
    add_column :tasks,:audit_state,:string,:limit => 30,:null => false,:default => "draft"
  end

  def down
  end
end
