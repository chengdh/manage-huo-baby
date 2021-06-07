# -*- encoding : utf-8 -*-
#定义一个根机构
Factory.define :department do |dep|
  dep.name 'department'
  dep.simp_name 'o'
  dep.phone  '0371-67519902'
  dep.manager  'org'
  dep.location  'location'
  dep.code  "code"
  dep.lock_input_time  "23:59"
end
Factory.define :branch do |branch|
  branch.name 'branch'
  branch.simp_name 'o'
  branch.phone  '0371-67519902'
  branch.manager  'org'
  branch.location  'location'
  branch.code  "code"
  branch.lock_input_time  "23:59"
end


Factory.define :zz,:parent => :branch do |org|
  org.name 'zz'
  org.simp_name '郑'
  org.phone  '0371-67519902'
  org.manager  '张三'
  org.location  '南三环燕赵物流园'
  org.code  "01"
  org.is_yard true
  org.is_summary true
  org.lock_input_time  "23:59"
end
Factory.define :ay,:parent => :branch do |org|
  org.name '安阳'
  org.simp_name '安'
  org.phone  '0371-67519902'
  org.manager  '张三'
  org.location  ''
  org.code  "AY"
  org.lock_input_time  "23:59"
end

Factory.define :sjz,:parent => :branch do |org|
  org.name '石家庄'
  org.simp_name '石'
  org.phone  '0371-67519902'
  org.manager  '张三'
  org.location  ''
  org.code  "sjz"
  org.lock_input_time  "23:59"
end
Factory.define :kf,:parent => :branch do |org|
  org.name '开封'
  org.simp_name '开'
  org.phone  '0371-67519902'
  org.manager  '张三'
  org.location  '开封'
  org.code  "开"
  org.lock_input_time  "23:59"
end

#机打票
Factory.define :computer_bill do |bill|
  bill.bill_date Date.today
  bill.from_customer_name "发货人"
  bill.from_customer_phone "13676997527"
  bill.from_customer_mobile "13676997527"
  bill.to_customer_name "收货人"
  bill.to_customer_phone "15138665197"
  bill.to_customer_mobile "13676997527"
  bill.association :from_org,:factory => :zz
  bill.association :to_org,:factory => :sjz
  bill.insured_amount 1000
  bill.insured_rate 0.001
  bill.carrying_fee 200
  bill.goods_fee 5000
  bill.from_short_carrying_fee 20
  bill.to_short_carrying_fee 20
  bill.pay_type CarryingBill::PAY_TYPE_CASH
  bill.goods_num 20
  bill.goods_info "机打运单"
end
#内部中转运单
Factory.define :inner_transit_bill do |bill|
  bill.bill_date Date.today
  bill.from_customer_name "发货人"
  bill.from_customer_phone "13676997527"
  bill.from_customer_mobile "13676997527"
  bill.to_customer_name "收货人"
  bill.to_customer_phone "15138665197"
  bill.to_customer_mobile "13676997527"
  bill.association :from_org,:factory => :ay
  bill.association :transit_org,:factory => :zz
  bill.association :to_org,:factory => :kf
  bill.insured_amount 1000
  bill.insured_rate 0.001
  bill.carrying_fee 200
  bill.goods_fee 5000
  bill.from_short_carrying_fee 20
  bill.to_short_carrying_fee 20
  bill.pay_type CarryingBill::PAY_TYPE_CASH
  bill.goods_num 20
  bill.goods_info "内部中转运单"
end

#带有VIP客户信息的票据
Factory.define :computer_bill_with_vip ,:parent => :computer_bill do |bill|
  bill.association :from_customer,:factory => :vip
end
#已装车机打票
Factory.define :computer_bill_loaded,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.after_create {|bill| bill.standard_process }  #装车操作
end
#已发货机打票
Factory.define :computer_bill_shipped,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.after_create do |bill|
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
  end
end
#已到货机打票
Factory.define :computer_bill_reached,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.after_create do |bill|
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
  end
end
#已分货机打票
Factory.define :computer_bill_distributed,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.distribution_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.after_create do |bill|
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
    bill.standard_process   #分货操作
  end
end
#已提货运单
Factory.define :computer_bill_deliveried,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.distribution_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.deliver_info_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.after_create do |bill|
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
    bill.standard_process   #分货操作
    bill.standard_process   #提货操作
  end
end
#已结算运单
Factory.define :computer_bill_settlemented,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.distribution_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.deliver_info_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.settlement_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.after_create do |bill|
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
    bill.standard_process   #分货操作
    bill.standard_process   #提货操作
    bill.standard_process   #结算操作
  end
end
#已返款确认运单
Factory.define :computer_bill_refounded_confirmed,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.distribution_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.deliver_info_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.settlement_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.refound_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.after_create do |bill|
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
    bill.standard_process   #分货操作
    bill.standard_process   #提货操作
    bill.standard_process   #结算操作
    bill.standard_process   #返款操作
    bill.standard_process   #返款确认
  end
end
#已做付款清单运单
Factory.define :computer_bill_payment_listed,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.distribution_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.deliver_info_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.settlement_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.refound_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.payment_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.after_create do |bill|
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
    bill.standard_process   #分货操作
    bill.standard_process   #提货操作
    bill.standard_process   #结算操作
    bill.standard_process   #返款操作
    bill.standard_process   #返款确认
    bill.standard_process   #结算清单
  end
end
#已支付货款运单
Factory.define :computer_bill_paid,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.distribution_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.deliver_info_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.settlement_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.refound_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.payment_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.pay_info_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.after_create do |bill|
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
    bill.standard_process   #分货操作
    bill.standard_process   #提货操作
    bill.standard_process   #结算操作
    bill.standard_process   #返款操作
    bill.standard_process   #返款确认
    bill.standard_process   #代收货款支付清单
    bill.standard_process   #代收货款提款
  end
end

#手工票
Factory.define :hand_bill do |bill|
  bill.bill_date Date.today
  bill.from_customer_name "发货人"
  bill.from_customer_phone "13676997527"
  bill.from_customer_mobile "13676997527"
  bill.to_customer_name "收货人"
  bill.to_customer_phone "15138665197"
  bill.to_customer_mobile "15138665197"
  bill.association :from_org,:factory => :zz
  bill.association :to_org,:factory => :sjz
  bill.insured_amount 1000
  bill.insured_rate 0.001
  bill.carrying_fee 200
  bill.goods_fee 5000
  bill.from_short_carrying_fee 20
  bill.to_short_carrying_fee 20
  bill.pay_type CarryingBill::PAY_TYPE_CASH
  bill.goods_num 20
  bill.bill_no "0200001"
  bill.goods_no "110320郑石11-100"
  bill.goods_info "手工运单"
end
#内部中转手工票
Factory.define :hand_inner_transit_bill do |bill|
  bill.bill_date Date.today
  bill.from_customer_name "发货人"
  bill.from_customer_phone "13676997527"
  bill.from_customer_mobile "13676997527"
  bill.to_customer_name "收货人"
  bill.to_customer_phone "15138665197"
  bill.to_customer_mobile "15138665197"
  bill.association :from_org,:factory => :kf
  bill.association :transit_org,:factory => :zz
  bill.association :to_org,:factory => :sjz
  bill.insured_amount 1000
  bill.insured_rate 0.001
  bill.carrying_fee 200
  bill.goods_fee 5000
  bill.from_short_carrying_fee 20
  bill.to_short_carrying_fee 20
  bill.pay_type CarryingBill::PAY_TYPE_CASH
  bill.goods_num 20
  bill.bill_no "0300005"
  bill.goods_no "110320开石11-100"
  bill.goods_info "内部手工中转运单"
end

#中转票
Factory.define :transit_bill do |bill|
  bill.bill_date Date.today
  bill.from_customer_name "发货人"
  bill.from_customer_phone "13676997527"
  bill.from_customer_mobile "13676997527"
  bill.to_customer_name "收货人"
  bill.to_customer_phone "15138665197"
  bill.to_customer_mobile "15138665197"
  bill.insured_amount 1000
  bill.insured_rate 0.001
  bill.carrying_fee 200
  bill.goods_fee 5000
  bill.from_short_carrying_fee 20
  bill.to_short_carrying_fee 20
  bill.pay_type CarryingBill::PAY_TYPE_TH
  bill.goods_num 20

  bill.goods_info "中转运单"
  bill.association :from_org,:factory => :sjz
  bill.association :transit_org,:factory => :zz
  bill.association :area,:factory => :area
end
Factory.define :transit_bill_reached,:parent => :transit_bill do |bill|
  bill.load_list_id 1
  bill.after_create do |bill|
    bill.standard_process   #装车操作
    bill.standard_process   #发车操作
    bill.standard_process   #到货确认
  end
end
Factory.define :transit_bill_transited,:parent => :transit_bill do |bill|
  bill.load_list_id 1
  bill.transit_info_id 1
  bill.after_create do |bill|
    bill.standard_process   #装车操作
    bill.standard_process   #发车操作
    bill.standard_process   #到货确认
    bill.standard_process   #中转
  end
end

#手工中转票
Factory.define :hand_transit_bill do |bill|
  bill.bill_date Date.today
  bill.from_customer_name "发货人"
  bill.from_customer_phone "13676997527"
  bill.from_customer_mobile "13676997527"
  bill.to_customer_name "收货人"
  bill.to_customer_phone "15138665197"
  bill.to_customer_mobile "15138665197"
  bill.insured_amount 1000
  bill.insured_rate 0.001
  bill.carrying_fee 200
  bill.goods_fee 5000
  bill.from_short_carrying_fee 20
  bill.to_short_carrying_fee 20
  bill.pay_type CarryingBill::PAY_TYPE_CASH

  bill.bill_no "0200002"
  bill.goods_no "110320安郑1-3"
  bill.goods_info "手工中转运单"
  bill.association :from_org,:factory => :ay
  bill.association :transit_org,:factory => :zz
  bill.association :area,:factory => :area
end
#大车装车单,还未装车
Factory.define :load_list do |load_list|
  load_list.bill_no "bill_no_001"
  load_list.association :from_org,:factory => :zz
  load_list.association :to_org,:factory => :ay
end
#中转装车单
Factory.define :transit_load_list,:parent => :load_list do |load_list|
  load_list.bill_no "bill_no_002"
  load_list.association :from_org,:factory => :kf
  load_list.association :transit_org,:factory => :zz
  load_list.association :to_org,:factory => :ay
end

Factory.define :load_list_with_bills,:parent => :load_list do |load_list|
  load_list.after_create do |load|
    load.carrying_bills << Factory(:computer_bill)
  end
end
#大车装车单,已装车
Factory.define :load_list_loaded,:parent => :load_list_with_bills do |load_list|
  load_list.after_create do |load|
    load.process
  end
end
#大车装车单,已发货
Factory.define :load_list_shipped,:parent => :load_list_with_bills do |load_list|
  load_list.after_create do |load|
    load.process
    load.process
  end
end
#分货单
Factory.define :distribution_list do |dl|
  dl.association :org,:factory => :ay
end
#提货单据
Factory.define :deliver_info do |deliver|
  deliver.customer_name "提货人"
  deliver.association :org,:factory => :zz
end
Factory.define :deliver_info_with_bills,:parent => :deliver_info do |deliver|
  deliver.after_create do |dl|
    dl.carrying_bills << Factory(:computer_bill_distributed)
  end
end

#返程运单结算
Factory.define :settlement do |s|
  s.association :org,:factory => :zz
end
Factory.define :settlement_with_bills,:parent => :settlement do |s|
  s.after_create do |st|
    st.carrying_bills << Factory(:computer_bill_deliveried)
  end
end
#返款清单
Factory.define :refound do |r|
  r.association :from_org,:factory => :zz
  r.association :to_org,:factory => :ay
end
Factory.define :refound_with_bills,:parent => :refound do |r|
  r.after_create do |rf|
    rf.carrying_bills << Factory(:computer_bill_settlemented)
  end
end
#客户信息
Factory.define :customer do |c|
  c.name "0000001"
  c.code "0000001"
  c.phone "0000001"
end
#银行信息
Factory.define :bank do |b|
  b.name "银行"
  b.code '0'
end
Factory.define :icbc,:parent => :bank do |b|
  b.name "中国工商银行"
  b.code '1'
end
#VIP客户信息
Factory.define :vip do |vip|
  vip.name "张三"
  vip.mobile "1763636634343"
  vip.association :org,:factory => :zz
  vip.association :bank,:factory => :icbc
  vip.bank_card "6222032031714562349"
  vip.association :config_transit,:factory => :config_vip
  vip.id_number "410221197510020418"
end
#现金代收货款支付清单
Factory.define :cash_payment_list do |p_list|
  p_list.association :org,:factory => :zz
end
Factory.define :cash_payment_list_with_bills,:parent => :cash_payment_list do |p_list|
  p_list.after_create do |pl|
    pl.carrying_bills << Factory(:computer_bill_refounded_confirmed)
  end
end
#银行代收货款转账清单
Factory.define :transfer_payment_list do |p_list|
  p_list.association :org,:factory => :zz
  p_list.association :bank,:factory => :icbc
end
Factory.define :transfer_payment_list_with_bills,:parent => :transfer_payment_list do |p_list|
  p_list.after_create do |pl|
    pl.carrying_bills << Factory(:computer_bill_refounded_confirmed)
  end
end
#客户提款-现金
Factory.define :cash_pay_info do |p|
  p.association :org,:factory => :zz
  p.customer_name "张三"
  p.id_number "412929197510020418"
  p.account_no "6222020001876098"
  p.account_name "张三"
  p.mobile '13676997572'
end
Factory.define :cash_pay_info_with_bills,:parent => :cash_pay_info do |p|
  p.after_create do |pi|
    pi.carrying_bills << Factory(:computer_bill_payment_listed)
  end
end
#客户提款-转账
Factory.define :transfer_pay_info do |p|
  p.association :org,:factory => :zz
  p.customer_name "张三"
  p.id_number "412929197510020418"
  p.account_name "张三"
  p.account_no "6222020001876098"
  p.mobile '13676997572'
end
Factory.define :transfer_pay_info_with_bills,:parent => :transfer_pay_info do |p|
  p.after_create do |pi|
    pi.carrying_bills << Factory(:computer_bill_payment_listed)
  end
end
#每日过帐信息汇总
Factory.define :post_info do |p|
  p.association :org,:factory => :zz
end
Factory.define :post_info_with_bills,:parent => :post_info do |p|
  p.after_create do |pi|
    pi.carrying_bills << Factory(:computer_bill_paid)
  end
end
#中转公司
Factory.define :transit_company do |tc|
  tc.name "长通物流"
  tc.phone "0371-68987709"
  tc.address "长通物流园区"
end
#中转票据中转信息
Factory.define :transit_info do |ti|
  ti.association :org,:factory => :zz
  ti.association :transit_company
end
Factory.define :transit_info_with_bill,:parent => :transit_info do |ti|
  ti.after_create do |tif|
    tif.carrying_bills << Factory(:transit_bill_reached)
  end
end
#中转票据提货信息
Factory.define :transit_deliver_info do |td|
  td.association :org,:factory => :zz
end
Factory.define :transit_deliver_info_with_bill,:parent => :transit_deliver_info do |td|
  td.after_create do |tdf|
  tdf.carrying_bills << Factory(:transit_bill_transited)
  end
end
Factory.define :role do |role|
  role.name "admin_role"
end

Factory.define :common_role,:parent => :role do |role|
  role.name "common_role"
end

Factory.define :user do |user|
  user.username "user"
  user.real_name "操作员"
  user.password "user"
  user.association :default_org,:factory => :zz
  user.association :default_role,:factory => :role
end
Factory.define :test_user,:class => :user do |user|
  user.username "test_user"
  user.real_name "测试操作员"
  user.password "test_user"
end

Factory.define :admin,:parent => :user do |admin|
  admin.username "admin"
  admin.password "admin"
  admin.is_admin true
  admin.association :default_org,:factory => :zz
  admin.association :default_role,:factory => :role
end
#手续费设置(现金)
Factory.define :config_cash do |config|
  config.fee_from 0
  config.fee_to 1000
  config.hand_fee 1
end
#手续费设置(转账)
Factory.define :config_transit do |config|
  config.name "转账手续费设置"
  config.rate 0.001
end
Factory.define :config_vip,:parent =>:config_transit do |config|
  config.name "vip客户"
  config.rate 0.001
end
Factory.define :config_common,:parent =>:config_transit do |config|
  config.name "普通客户"
  config.rate 0.003
end
#短途运费管理
Factory.define :short_fee_info do |model|
  model.association :org,:factory => :zz
end
#il_config
Factory.define :il_config do |config|
  config.key "il_key"
  config.title "il_title"
  config.value 'il_value'
end
#remittance 汇款记录
Factory.define :remittance do |remittance|
  remittance.association :from_org,:factory => :zz
  remittance.association :to_org,:factory => :sjz
  remittance.association :refound,:factory => :refound_with_bills
  remittance.should_fee 5000
  remittance.act_fee 5000
end
#goods_exception
Factory.define :goods_exception do |gx|
  gx.association :org,:factory => :zz
  gx.association :op_org,:factory => :zz
  gx.association :carrying_bill,:factory => :computer_bill
  gx.exception_type "LA"
  gx.except_num 10
end
#gexception_authorize_info
Factory.define :gexception_authorize_info do |authorize_info|
  authorize_info.association :goods_exception,:factory => :goods_exception
  authorize_info.op_type "FO"
  authorize_info.compensation_fee 100
end
#goods_exception_2 多货少货信息
Factory.define :goods_error do |ge|
  ge.association :org,:factory => :zz
  ge.association :op_org,:factory => :zz
  ge.except_type "SH"
  ge.except_num 1
end

#journal
Factory.define :journal do |journal|
  journal.association :org,:factory => :zz
end
#sender
Factory.define :sender do |sender|
  sender.name 'sender'
  sender.id_number '412929197510020418'
  sender.association :org ,:factory => :zz
end
#send_list
Factory.define :send_list do |sl|
  sl.association :sender,:factory => :sender
  sl.association :org,:factory => :zz
end
#send_list_line
Factory.define :send_list_line do |sl_line|
  sl_line.association :carrying_bill,:factory => :computer_bill
  sl_line.association :send_list,:factory => :send_list
end
#send_list_post
Factory.define :send_list_post do |sl_post|
  sl_post.association :sender,:factory => :sender
  sl_post.association :org,:factory => :zz
  sl_post.after_create do |p|
    p.send_list_lines << Factory(:send_list_line)
  end
end
#send_list_back
Factory.define :send_list_back do |sl_back|
  sl_back.association :sender,:factory => :sender
  sl_back.association :org,:factory => :zz
  sl_back.after_create do |p|
    p.send_list_lines << Factory(:send_list_line)
  end
end
#customer_level_config
Factory.define :customer_level_config do |config|
  config.name "cl_config"
  config.association :org,:factory => :zz
  config.from_fee 0
  config.to_fee 1000
end
#Area
Factory.define :area do |area|
  area.name "西安"
end
#Notify
Factory.define :notify do |n|
  n.notify_text "提醒信息"
end
#goods_fee_settlement_list
#分理处提款结算清单
Factory.define :goods_fee_settlement_list do |gfs|
  gfs.association :org,:factory => :zz
  gfs.association :post_info,:factory => :post_info_with_bills
  gfs.amount_fee 2000
  gfs.amount_goods_fee 19999
  gfs.amount_hand_fee 200
  gfs.amount_k_carrying_fee 487
  gfs.amount_bills 19
end
#货物分类
Factory.define :goods_cat do |gc|
  gc.name "家具"
end
#货物分类费用
Factory.define :goods_cat_fee_config do |gcfc|
  gcfc.association :from_org,:factory => :zz
  gcfc.association :to_org,:factory => :ay
end
Factory.define :goods_cat_fee_config_line do |line|
  line.bottom_price 11.12
  line.unit_price 14
  line.association :goods_cat,:factory => :goods_cat
end
#到货提醒
Factory.define :notice do |n|
  n.association :org,:factory => :zz
  n.load_list_id 1
end
#到货提醒明细
Factory.define :notice_line do |nl|
  nl.association :carrying_bill,:factory => :computer_bill
  nl.from_customer_phone "13567894567"
  nl.calling_text "13567894567"
  nl.sms_text "13567894567"
end
#条码装车清单
Factory.define :load_list_with_barcode do |l|
  l.association :from_org,:factory => :zz
  l.association :to_org,:factory => :ay
  l.note "test"
end
#条码装车单明细
Factory.define :load_list_with_barcode_line do |l|
  l.association :load_list_with_barcode,:factory => :load_list_with_barcode
  l.barcode "0134000004008002"
end
#分理处盘货单
Factory.define :branch_inventory do |l|
  l.association :from_org,:factory => :ay
  l.association :to_org,:factory => :zz
end
Factory.define :act_load_list_line do |l|
  l.association :act_load_list,:factory => :branch_inventory
  l.association :carrying_bill,:factory => :computer_bill
  l.load_num  1
end
#货场盘货单
Factory.define :yard_inventory do |l|
  l.association :from_org,:factory => :zz
  l.association :to_org,:factory => :ay
end
Factory.define :act_load_list_line_2,:class => :act_load_list_line do |l|
  l.association :act_load_list,:factory => :yard_inventory
  l.association :carrying_bill,:factory => :computer_bill
  l.load_num  1
end
#运费减免记录
Factory.define :adjust_fee_info do |a|
  a.association :org,:factory => :ay
  a.association :op_org,:factory => :zz
  a.adjust_fee(-10)
  a.note "测试运费减免"
  a.association :carrying_bill,:factory => :computer_bill
end
#在库清单
Factory.define :in_stock_bill do |i|
  i.association :org,:factory => :zz
  i.association :op_org,:factory => :kf
  i.user_id 1
end
#在库清单明细
Factory.define :in_stock_bill_line do |l|
  l.association :in_stock_bill,:factory => :in_stock_bill
  l.association :carrying_bill,:factory => :computer_bill
end

#欠款提货清单
Factory.define :debt_bill do |db|
  db.association :org,:factory => :zz
  db.association :op_org,:factory => :kf
  db.user_id 1
end
#预付款凭证
Factory.define :prepay_entry do |p|
  p.association :org,:factory => :kf
  p.debit 1000
  p.credit 2000
  p.balance -1000
end

#实提运费报表
Factory.define :carrying_fee_th_rpt do |rpt|
  rpt.association :from_org,:factory => :kf
  rpt.association :to_org,:factory => :zz
  rpt.bill_date Date.today
  rpt.carrying_fee 100
end

#投票信息
Factory.define :vote_config do |vc|
  vc.name "201408主管领导评分"
  vc.mth "201408"
  vc.expire_date Date.today.end_of_month.to_date
end

#投票设置项目
Factory.define :votable_item do |item|
  item.name "张三"
  item.association :vote_config,:factory => :vote_config
end

#通讯录
Factory.define :address_book do |ab|
  ab.name "测试分理处"
  ab.address "分理处地址"
  ab.phone "联系电话"
end
#短途费生成设置
Factory.define :short_fee_config do |sfc|
  sfc.name "测试短途费"
  sfc.association :from_org,:factory => :zz
  sfc.association :to_org,:factory => :kf
  sfc.operator "lte"
  sfc.carrying_fee 100
  sfc.short_fee_rate 0.01
#送货区域
Factory.define :deliver_region do |dr|
  dr.association :org,:factory => :zz
  dr.name "deliver region no1"
  dr.province_code "410000"
  dr.city_code "410001"
  dr.district_code "415001"
end
