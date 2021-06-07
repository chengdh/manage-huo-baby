# -*- encoding : utf-8 -*-
#coding: utf-8
class CustomerCodeValidator < ActiveModel::EachValidator
  def validate_each(object,attribute,value)
    if value.present?
      object.errors[attribute] << options[:message] || "客户编号与姓名不匹配" unless Customer.exists?(:code => value,:name => object.from_customer_name,:is_active => true)
    end
  end
end

