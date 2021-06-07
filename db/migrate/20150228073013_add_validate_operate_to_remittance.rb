#coding: utf-8
#给汇款记录添加核对操作
class AddValidateOperateToRemittance < ActiveRecord::Migration
  def change
    group_name = "结算管理"
    subject_title = "汇款记录"
    sf = SystemFunction.find_by_subject_title(subject_title)
    subject = "Remittance"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :function => {
        :validate => {:title => "核对",:conditions =>"{:state => 'complete'}"}
      }
    }
    sf.update_by_hash(sf_hash) if sf.present?
  end
end
