#自动计算运单
class AutoCalculateComputerBillsController < CarryingBillsController
  defaults :resource_class => AutoCalculateComputerBill
  include BillOperate::BillPrint

  #override new
  #GET auto_calculate_computer_bills/new
  def new
    super do
      bill = get_resource_ivar
      (3 - bill.bill_lines.size).times { bill.bill_lines.build }
    end
  end
end
