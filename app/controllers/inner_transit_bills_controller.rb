#coding: utf-8
#内部中转票据
class InnerTransitBillsController < CarryingBillsController
  defaults :resource_class => InnerTransitBill
  include BillOperate::BillPrint
end
