#coding: utf-8
#给bill_association_objects添加相关字段
class ChangeBillAssociationObject < ActiveRecord::Migration
  def up
    Lhm.change_table :bill_association_objects,:atomic_switch => true do |m|
      m.add_column :from_org_divide_fee,"DECIMAL(15,2) DEFAULT 0"
      m.add_column :to_org_divide_fee,"DECIMAL(15,2) DEFAULT 0"
      m.add_column :transit_org_divide_fee,"DECIMAL(15,2) DEFAULT 0"
      m.add_column :summary_org_divide_fee,"DECIMAL(15,2) DEFAULT 0"
      m.add_column :other_org_1_id,"INT(11)"
      m.add_column :other_org_1_divide_fee,"DECIMAL(15,2) DEFAULT 0"
      m.add_column :other_org_2_id,"INT(11)"
      m.add_column :other_org_2_divide_fee,"DECIMAL(15,2) DEFAULT 0"
      m.add_column :other_org_3_id,"INT(11)"
      m.add_column :other_org_3_divide_fee,"DECIMAL(15,2) DEFAULT 0"
      m.add_column :other_org_4_id,"INT(11)"
      m.add_column :other_org_4_divide_fee,"DECIMAL(15,2) DEFAULT 0"

      m.add_index :other_org_1_id
      m.add_index :other_org_2_id
      m.add_index :other_org_3_id
      m.add_index :other_org_4_id
    end
  end

  def down
    Lhm.change_table :bill_association_objects,:atomic_switch => true  do |m|
      m.remove_column :from_org_divide_fee
      m.remove_column :to_org_divide_fee
      m.remove_column :transit_org_divide_fee
      m.remove_column :summary_org_divide_fee
      m.remove_column :other_org_1_id
      m.remove_column :other_org_1_divide_fee
      m.remove_column :other_org_2_id
      m.remove_column :other_org_2_divide_fee
      m.remove_column :other_org_3_id
      m.remove_column :other_org_3_divide_fee
      m.remove_column :other_org_4_id
      m.remove_column :other_org_4_divide_fee

      m.remove_index :other_org_1_id
      m.remove_index :other_org_2_id
      m.remove_index :other_org_3_id
      m.remove_index :other_org_4_id
    end
  end
end
