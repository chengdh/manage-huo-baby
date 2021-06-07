#coding:utf-8
#运费分成报表
class AddDivideRptYujiuFunction < ActiveRecord::Migration
  def up
    group_name = "分成报表"
    subject_title = "分成报表-宇玖"
    subject = "DivideRptYujiu"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => "divide_rpt_yujius_path",
      :subject => subject,
      :function => {
        :read =>{:title => "查看"} ,
        :create => {:title => "新建"},
        :confirm => {:title => "确认",:conditions =>"{:state => 'saved' }"},
        :destroy =>{:title => "删除",:conditions =>"{:state => ['draft','saved']}"} ,
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
