#coding: utf-8
class CreateFeeUnits < ActiveRecord::Migration
  def change
    create_table :fee_units do |t|
      t.string :name,:null => false,:limit => 60
      t.string :unit_simp,:limit => 20
      t.boolean :is_active,:default => true
      t.integer :order_by
      t.text :note

      t.timestamps
    end
  end
end
