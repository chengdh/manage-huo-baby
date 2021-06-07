#coding: utf-8
#carrying_bill audited 监听器
class AuditedObserver < ActiveRecord::Observer
  observe Audited::Adapters::ActiveRecord::Audit
  #生成prepay_entry,规则如下:
  #运单注销、原货返回时，应将该单据提货应收金额自动显示到借方栏；
  #票据货款修改时，应将差额（修改前的货款-修改后的货款）显示到借方栏，如修改前货款小于修改后货款，则以负数表示；
  #修改运费支付方式时，如提货付改为其他方式，将总运费加上保险费显示到借方栏， 
  #如其他支付方式改为提货付，将总运费加上保险费以负数形式显示到借方栏。
  #期初数据自动计算出来，并可以修改
  #
  def after_create(audit)
    #NOTE 不处理中转业务
    bill = audit.auditable
    return if (not ["ComputerBill","HandBill","ReturnBill","AutoCalculateComputerBill"].include?(bill.type)) or bill.transit_org_id.present?
    on_cancel(audit)
    on_return(audit)
    on_change_goods_fee(audit)
    on_change_fee(audit,'carrying_fee','运费')
    on_change_fee(audit,'insured_fee','保险费')
    #20151010 预付款凭证不再处理发货及到货短途
    on_change_fee(audit,'from_short_carrying_fee','发货短途费')
    #on_change_fee(audit,'to_short_carrying_fee','到货货短途费')
    on_change_pay_type(audit)
    on_reset(audit)
  end

  private
  #票据注销
  def on_cancel(audit)
    if audit.audited_changes.try(:include?,'goods_info') and audit.new_attributes['goods_info'].try(:end_with?,'#cancel')
      bill = audit.auditable

      last_prepay_entry = PrepayEntry.last_entry(bill.to_org_id)

      last_balance =  last_prepay_entry.balance
      debit = bill.th_amount  - bill.to_short_carrying_fee_th
      balance = last_balance - debit
      PrepayEntry.create!(:org => bill.to_org,:debit => debit,:balance => balance,:note => "#{bill.bill_no}运单注销")
    end
  end
  #重置
  def on_reset(audit)
    if audit.audited_changes.try(:include?,'goods_info') and audit.new_attributes['goods_info'].try(:end_with?,'#reset')
      bill = audit.auditable
      #添加货物备注
      BillNote.create!(:user => audit.user,:carrying_bill => bill,:note => "重置操作")

      #预付款凭证
      last_prepay_entry = PrepayEntry.last_entry(bill.to_org_id)
      last_balance =  last_prepay_entry.balance
      debit = bill.th_amount  - bill.to_short_carrying_fee_th
      balance = last_balance - debit
      PrepayEntry.create!(:org => bill.to_org,:debit => debit,:balance => balance,:note => "#{bill.bill_no}运单重置")
    end
  end

  #原货返回
  def on_return(audit)
    if audit.audited_changes.try(:include?,'goods_info') and audit.new_attributes['goods_info'].try(:end_with?,'#return')
      bill = audit.auditable
      last_prepay_entry = PrepayEntry.last_entry(bill.to_org_id)
      last_balance =  last_prepay_entry.balance
      debit = bill.th_amount - bill.to_short_carrying_fee_th
      balance = last_balance - debit

      PrepayEntry.create!(:org => bill.to_org,:debit => debit,:balance => balance,:note => "#{bill.bill_no}运单退货")
    end
  end
  #修改货款
  def on_change_goods_fee(audit)
    if audit.audited_changes.try(:include?,'goods_fee')
      bill = audit.auditable
      if ['shipped','reached','distributed'].include?(bill.state)
        old_goods_fee = audit.old_attributes['goods_fee']
        new_goods_fee = audit.new_attributes['goods_fee']
        debit = old_goods_fee - new_goods_fee

        if debit != 0
          last_prepay_entry = PrepayEntry.last_entry(bill.to_org_id)
          last_balance =  last_prepay_entry.balance
          balance = last_balance - debit
          PrepayEntry.create!(:org => bill.to_org,:debit => debit,:balance => balance,:note => "#{bill.bill_no}修改货款")
        end
      end
    end
  end

  #运费、保险费、发货短途、到货短途变化时处理
  def on_change_fee(audit,fee_name,fee_desc)
    if audit.audited_changes.try(:include?,fee_name)
      bill = audit.auditable
      if bill.pay_type.eql?(CarryingBill::PAY_TYPE_TH) and ['shipped','reached','distributed'].include?(bill.state)
        last_balance =  PrepayEntry.last_entry(bill.to_org_id).balance
        old_fee = audit.old_attributes[fee_name]
        new_fee = audit.new_attributes[fee_name]
        debit = old_fee - new_fee

        if debit != 0
          last_prepay_entry = PrepayEntry.last_entry(bill.to_org_id)
          last_balance =  last_prepay_entry.balance

          balance = last_balance - debit
          PrepayEntry.create!(:org => bill.to_org,:debit => debit,:balance => balance,:note => "#{bill.bill_no}修改#{fee_desc}")
        end
      end
    end
  end

  #修改支付方式
  def on_change_pay_type(audit)
    if audit.audited_changes.try(:include?,'pay_type')
      bill = audit.auditable
      #由提货付修改为其他支付方式
      if ['shipped','reached','distributed'].include?(bill.state)
        if audit.old_attributes['pay_type'].eql?(CarryingBill::PAY_TYPE_TH)
          last_prepay_entry = PrepayEntry.last_entry(bill.to_org_id)
          #需要调整期初余额
          debit = bill.carrying_fee_th_total + bill.insured_fee_th
          last_balance =  last_prepay_entry.balance
          balance = last_balance - debit
          PrepayEntry.create!(:org => bill.to_org,:debit => debit,:balance => balance,:note => "#{bill.bill_no}修改支付方式")
        end
        if audit.new_attributes['pay_type'].eql?(CarryingBill::PAY_TYPE_TH)
          debit = bill.carrying_fee_th_total + bill.insured_fee_th
          last_prepay_entry = PrepayEntry.last_entry(bill.to_org_id)
          last_balance =  last_prepay_entry.balance
          balance = last_balance + debit
          PrepayEntry.create!(:org => bill.to_org,:debit => -debit,:balance => balance,:note => "#{bill.bill_no}修改支付方式")
        end
      end
    end
  end
end
