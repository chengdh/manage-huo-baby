#coding: utf-8
#分支机构自身维护的客户资料信息
class BranchCustomer < Customer
  belongs_to :org
  belongs_to :deliver_region

  def address_desc_for_print
    ret = "#{deliver_region.try(:district_desc_for_print)}"
    ret = "#{ret}>#{address}" if address.present?
    ret
  end
  def self.get_address_desc_for_print(org_id,mobile)
    ret = ""
    b_customer = BranchCustomer.search(:org_id_eq => org_id,:mobile_or_mobile_2_or_mobile_3_or_mobile_4_or_mobile_5_eq => mobile).try(:first)
    return ret if b_customer.blank?

    ret = "#{b_customer.deliver_region.try(:district_desc_for_print)}"
    ret = "#{ret}>#{b_customer.address}" if b_customer.address.present?
    ret
  end

end
