#coding: utf-8
#添加预付款凭证调帐功能
class AddCreateFunctionToPrepayEntry < ActiveRecord::Migration
  def change
    #添加预付款凭证调帐
    sf = SystemFunction.find_by_subject_title('预付款凭证')
    func_obj =  {
      :subject => "PrepayEntry",
      :action => :create
    }

    if sf
      ops = sf.system_function_operates.find_or_create_by_name("手工调帐")
      ops.update_attributes(:new_function_obj => func_obj,:function_obj => func_obj)
    end
  end
end
