#coding: utf-8
#修改盘货相关功能
class ChangeInventoryFunctions < ActiveRecord::Migration
  def change
    #货场盘货单据-- 分公司盘货单
    sf = SystemFunction.find_by_subject_title('货场盘货单')
    sf.update_attributes(:subject_title => '分公司盘货单') if sf
    #分理处货物滞留清单--- 分公司货物滞留清单
    sf = SystemFunction.find_by_subject_title('分理处货物滞留清单')
    sf.update_attributes(:subject_title => '货物滞留清单(分理处)') if sf
    #货场货物滞留清单--- 分公司货物滞留清单
    sf = SystemFunction.find_by_subject_title('货场货物滞留清单')
    sf.update_attributes(:subject_title => '货物滞留清单(分公司)') if sf
    #修改菜单显示顺序
    sf = SystemFunction.find_by_subject_title('分理处盘货单(待确认)')
    sf.update_attributes(:order => 10)

    #
  end
end
