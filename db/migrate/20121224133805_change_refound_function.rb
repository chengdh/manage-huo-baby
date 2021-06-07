#coding: utf-8
#修改返款清单,添加查看选项
class ChangeRefoundFunction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('收款清单管理')
    default_action = 'can?(:read_arrive,Refound)? receive_refounds_path("search[state_eq]" => "refunded") : receive_refounds_path("search[state_eq]" => "refunded_confirmed") '
    sf.update_attributes(:default_action => default_action)
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('查看确认付款单')
      function_obj = {
        :subject => "Refound",
        :action => :read_confirmed
      }
      sfo.function_obj = function_obj
      sfo.new_function_obj = function_obj
      sfo.save!
    end
  end

  def down
  end
end
