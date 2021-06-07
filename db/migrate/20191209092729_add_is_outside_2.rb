#coding: utf-8
class AddIsOutside2 < ActiveRecord::Migration
  def up
    add_column :bill_association_objects,:is_outside,:boolean,:default => false
  end

  def down
    remove_column :bill_association_objects,:is_outside
  end
end
