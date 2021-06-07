# -*- encoding : utf-8 -*-
#coding: utf-8
module SendListModule
  #导出
  def to_csv
    ret = ["清单日期:",self.bill_date,"送货员:",self.sender.name,"所属机构:",self.org.name].export_line_csv(true)
    export_options = {
      :only => [],
      :methods => [:bill_date,:bill_no,:goods_no,:from_customer_name,:from_customer_phone,:from_customer_mobile,
        :to_customer_name,:to_customer_phone,:to_customer_mobile,:carrying_fee_th,:goods_fee,:note
    ]
    }
    csv_carrying_bills = self.carrying_bills.export_csv(export_options,false)
    sum_foot = ["合计","","","","","","","","",self.sum_carrying_fee_th,self.sum_goods_fee,""].export_line_csv
    ret + csv_carrying_bills + sum_foot
  end
end

