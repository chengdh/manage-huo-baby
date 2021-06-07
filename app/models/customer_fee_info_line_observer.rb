#coding: utf-8
class CustomerFeeInfoLineObserver < ActiveRecord::Observer
  def after_save(fee_info_line)
    update_imported_customer(fee_info_line)
  end
  private
  def update_imported_customer(fee_info_line)
    if fee_info_line.code.present?
      exist_imported_customer = ImportedCustomer.find_by_code( fee_info_line.code)
      if exist_imported_customer.present?
        exist_imported_customer.update_attributes(:cur_fee => fee_info_line.fee,:last_import_mth => fee_info_line.customer_fee_info.mth)
      else
        imported_customer = ImportedCustomer.create!(:code => fee_info_line.code,
                                               :cur_fee => fee_info_line.fee,
                                               :last_import_mth => fee_info_line.customer_fee_info.mth,
                                               :org_id => fee_info_line.customer_fee_info.org_id,
                                               :name => fee_info_line.name,
                                               :mobile => fee_info_line.phone,
                                               :level => CustomerLevelConfig::VIP_NORMAL)
      end
    else
      no_code_imported_customer = ImportedCustomer.find_or_create_by_org_id_and_name_and_mobile(fee_info_line.customer_fee_info.org_id,fee_info_line.name,fee_info_line.phone)
      no_code_imported_customer.update_attributes(:cur_fee => fee_info_line.fee,:last_import_mth => fee_info_line.customer_fee_info.mth)
    end
  end
end
