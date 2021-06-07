# -*- encoding : utf-8 -*-
class TransitBillsController < CarryingBillsController
  defaults :resource_class => TransitBill
  include BillOperate::BillPrint
end

