#coding: utf-8
#添加盘货功能设置
class AddInventoryFunctions < ActiveRecord::Migration
  def up
    #盘货管理模块
    group_name = "盘货操作"
    #################################分理处盘货单################################################
    subject_title = "分理处盘货单"
    subject = "BranchInventory"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'branch_inventories_path("search[bill_date_eq]" => Date.today,:sort => "bill_date")',
      :function => {
        :create => {:title => "新建"},
        :destroy => {:title => "删除"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
    #################################货场盘货单################################################
    subject_title = "货场盘货单"
    subject = "YardInventory"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'yard_inventories_path("search[bill_date_eq]" => Date.today,:sort => "bill_date")',
      :function => {
        :create => {:title => "新建"},
        :destroy => {:title => "删除"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)

    #######################分理处滞留统计################################################
    subject_title = "分理处货物滞留清单"
    subject = "BranchInventory"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'search_bills_branch_inventories_path',
      :subject => subject,
      :function => {
        :do_search_bills =>{:title =>"分理处滞留清单"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
    #######################货场滞留统计################################################
    subject_title = "货场货物滞留清单"
    subject = "YardInventory"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'search_bills_yard_inventories_path',
      :subject => subject,
      :function => {
        :do_search_bills =>{:title =>"货场货物滞留清单"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
