#coding: utf-8
#分公司-手工运单
class BranchBillsController < CarryingBillsController
  defaults :resource_class => BranchBill
end
