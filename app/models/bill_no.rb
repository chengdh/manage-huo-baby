# -*- encoding : utf-8 -*-
#运单编号生成器
class BillNo < ActiveRecord::Base
  def self.gen_bill_no
    #FIXME 默认机打运单从400000开始递增
    #查找当天是否有记录，如果没有，将bill_count重置为0
    bill_no = BillNo.find_or_create_by_id(1)
    today = Date.today
    if today != bill_no.updated_at.to_date
      bill_no.update_attributes(:bill_count => 0)
    end 
    BillNo.increment_counter(:bill_count,1)
    bill_no.reload.bill_count
  end
end

