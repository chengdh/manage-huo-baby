#coding: utf-8
class AddColsToAddressBook < ActiveRecord::Migration
  def change
    add_column :address_books,:simp_name,:string,:limit => 10
    add_column :address_books,:leader_mobile,:string,:limit => 30
    add_column :address_books,:second_leader,:string,:limit => 30
    add_column :address_books,:second_leader_mobile,:string,:limit => 30
  end
end
