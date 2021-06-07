#coding: utf-8
class CreateBillNotes < ActiveRecord::Migration
  def change
    create_table :bill_notes do |t|
      t.string :note,:null => false,:limit => 60
      t.references :user,:null => false
      t.references :carrying_bill,:null => false

      t.timestamps
    end
    add_index :bill_notes, :user_id
    add_index :bill_notes, :carrying_bill_id
  end
end
