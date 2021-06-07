#coding: utf-8
class ChangeImportedCustomerFunction < ActiveRecord::Migration
  def up
    subject_title = '客户分级'
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      sf.update_attributes(:default_action => "imported_customers_path('search[org_id_in]' => current_user.current_ability_org_ids)",
                          :subject_title => "普通客户资料")

      sfo = sf.system_function_operates.find_by_name("查看")
      if sfo
        function_obj = {:subject => "ImportedCustomer",:action => :read}
        sfo.function_obj = function_obj
        sfo.new_function_obj = function_obj
        sfo.save!
      end
    end
  end

  def down
  end
end
