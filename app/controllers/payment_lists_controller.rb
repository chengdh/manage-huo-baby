#coding: utf-8
class PaymentListsController < BaseController
  # include BillOperate
  # defaults :resource_class => PaymentList
  table :bill_date,:bank,:user,:note,:human_state_name
end
