#coding: utf-8
#按照吨或方计算费用的运单
class TonVolumeBillsController < CarryingBillsController
  defaults :resource_class => TonVolumeBill
  include BillOperate::BillPrint

  #override new
  #GET ton_volume_computer_bills/new
  def new
    super do
      bill = get_resource_ivar
      (3 - bill.bill_lines.size).times { bill.bill_lines.build }
    end
  end
end
