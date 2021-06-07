#coding: utf-8
class LocalTownBillsController < CarryingBillsController
  defaults :resource_class => LocalTownBill
  include BillOperate::BillPrint
end
