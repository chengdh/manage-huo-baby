# -*- encoding : utf-8 -*-
class ComputerBillsController < CarryingBillsController
  defaults :resource_class => ComputerBill
  include BillOperate::BillPrint
end
