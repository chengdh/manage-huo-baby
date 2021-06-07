class Ability
  include CanCan::Ability
  attr_accessor :user
  def initialize(a_user)
    # can :manage,:all
    @user = a_user
    set_alias_actions
    set_user_powers
    set_bill_update_permission
  end
  private
  def set_alias_actions
    #可以查看,就可以查询

    alias_action :read,:to => :read_all
    alias_action :search,:to => :read

    #导出到excel，从export映射到export_excel
    alias_action :export_excel,:to => :export
    alias_action :export_excel_for_kingdee,:to => :export
    alias_action :export_excel_transfer_payment_list_for_kingdee,:to => :export
    #未提货报表
    alias_action :simple_search,:to => :rpt_no_delivery
    #本地未提货报表
    alias_action :simple_search,:to => :local_rpt_no_delivery

    #本地未提货统计(中转)
    alias_action :simple_search,:to => :transit_local_rpt_no_delivery

    #送货报表
    alias_action :simple_search,:to => :rpt_delivery

    #始发地收货统计
    alias_action :read,:to => :rpt_to_me
    #提货未提款统计
    alias_action :simple_search,:to => :rpt_no_pay
    #日营业额统计
    alias_action :rpt_turnover,:to => :rpt_daily_income
    #月营业额统计
    alias_action :rpt_turnover,:to => :rpt_mth_income
    #退货未发票据统计
    alias_action :simple_search,:to => :rpt_return_no_ship

    #内部中转-运费/货款统计
    alias_action :simple_search,:to => :rpt_inner_transit_carrying_fee_goods_fee
    #外部中转-运费/货款统计
    alias_action :simple_search,:to => :rpt_outter_transit_carrying_fee_goods_fee
    #运费调整统计表
    alias_action :simple_search,:to => :rpt_adjust_carrying_fee

    alias_action :read,:to => :simple_search
    alias_action :read,:to => :export_excel
    alias_action :read,:to => :rpt_turnover
    alias_action :read,:to => :turnover_chart
    #代收货款收入/支出统计
    alias_action :read,:to => :sum_goods_fee_inout
    #before_new是新建退货单的初始页面
    alias_action :before_new,:to => :create

    alias_action :read,:to => :process_handle #发车
    alias_action :process_handle,:to => :ship  #发车
    alias_action :process_handle,:to => :reach #到货确认
    alias_action :process_handle,:to => :refound_confirm #收款清单确认

    #中转装车单
    alias_action :process_handle,:to => :ship_from_org
    alias_action :process_handle,:to => :reach_transit_org
    alias_action :process_handle,:to => :ship_transit_org
    alias_action :process_handle,:to => :reach_to_org

    #中转返款单
    alias_action :process_handle,:to => :confirm_transit_org
    alias_action :process_handle,:to => :confirm_to_org


    #汇款记录确认
    alias_action :process_handle,:to => :validate

    #结算员交款清单-交款确认
    alias_action :process_handle,:to => :settlement_confirm
    #代收货款支付清单(转账)转账确认
    alias_action :process_handle,:to => :transfer  #转账确认
    #user 重设置usb key
    alias_action :read,:update => :reset_usb_pin #重设usb pin
    #结算员交款清单-中转交款确认
    alias_action :read,:to => :direct_refunded_confirmed
    #批量提货
    alias_action :read,:create,:to => :batch_deliver #批量提货
    alias_action :read,:create,:to => :print_deliver #打印提货

    #理赔
    alias_action :read,:update,:to => :show_authorize #授权核销
    alias_action :read,:update,:to => :show_claim
    alias_action :read,:update,:to => :show_identify

    #理赔信息,核销前可修改
    alias_action :read,:update,:to => :update_with_submited

    #运费及货款修改
    alias_action :read,:update,:to => :update_carrying_fee_20
    alias_action :read,:update,:to => :update_carrying_fee_50
    alias_action :read,:update,:to => :update_carrying_fee_100
    alias_action :read,:update,:to => :update_goods_fee
    alias_action :read,:update,:to => :update_all
    #修改录单限制时间
    alias_action :read,:update,:to => :only_edit_lock_time


    #设置默认权限,可以修改/新建/删除,就具备查看权限
    alias_action :read ,:to => :create
    alias_action :read ,:to => :update
    alias_action :read ,:to => :destroy
    alias_action :read ,:to => :reset
    #可打印运单,就具备运单打印计数功能
    alias_action :read ,:print_counter,:to => :print
    alias_action :read ,:to => :invalidate #运单作废
    #可导出到货通知短信文本,就可显示短信文本生成界面
    alias_action :show_export_sms,:to => :export_sms_txt
    #中转装车单、中转返款单导出
    alias_action :export_excel,:to => :export_from_org
    alias_action :export_excel,:to => :export_transit_org
    alias_action :export_excel,:to => :export_to_org
    #运费调整,可以审批与驳回,就可以显示处理表单
    alias_action :show_operate_form,:to => :pass
    alias_action :show_operate_form,:to => :deny

    #分理处盘货单
    alias_action :before_check,:to => :check

  end
  #设置单个operate的权限
  def set_single_operate_power(sfo)
    begin
      current_ability_org_ids = user.current_ability_org_ids
      f_obj = sfo.new_function_obj
      subject_class = f_obj[:subject].constantize
      action = f_obj[:action].to_sym
      conditions = eval(f_obj[:conditions].to_s)
      can action,subject_class,conditions
      can :read_with_conditions,subject_class ,conditions if action.eql?(:read)
    rescue 
    end
  end
  #设置当前用户权限
  def set_user_powers
    # can :manage,:all
    if user.is_admin?
      SystemFunctionOperate.all.each { |sfo| set_single_operate_power(sfo)}
    else
      user.default_role.selected_sfos.each  { |sfo| set_single_operate_power(sfo)}
    end
    #设定用户对运单的操作权限
    ability_org_ids = user.current_ability_org_ids
    #定义运单的读权限,设定alias_action时,conditions 会丢失
    #read_with_conditoins 只在accessible_by中使用
    can :read_with_conditions,CarryingBill,['carrying_bills.from_org_id in (?) or carrying_bills.transit_org_id in (?)  or carrying_bills.to_org_id in (?)',ability_org_ids,ability_org_ids,ability_org_ids] do |bill|
      ability_org_ids.include?(bill.from_org_id) or ability_org_ids.include?(bill.to_org_id) or ability_org_ids.include?(bill.transit_org_id)
    end
    can :read,CarryingBill
    can :export_excel,CarryingBill
    #默认可查询运费
    can :simple_search,CarryingBill
    #录入票据时,默认可读取转账客户信息
    can :read,Vip
    can :read_with_conditions,Vip

    #登录时,可操作current_role_change action
    can :current_role_change,Role
    #登录后,可修改自身密码
    can :edit_password,User
    #可更新自身密码
    can :update_password,User

    #可查看imported_customer，就可查看customer_fee_info
    can :read,CustomerFeeInfo if can? :read,ImportedCustomer
    can :fee_lines,ImportedCustomer if can? :read,ImportedCustomer

    can :read,PaymentList


    can :query_for_bill_input,BranchCustomer if can? :read,BranchCustomer

    #可创建实际装车清单
    can :create,YardInventory if can? :build_act_load_list,LoadList
    #可创建到货通知清单如果有build_notice权限
    can :create,Notice if can? :build_notice,LoadList
    can :new_with_no_delivery,Notice if can? :build_notice,CarryingBill
    can :create,Notice if can? :build_notice,CarryingBill
    #可以查看vip就可以导出数据
    can :export_excel,Vip if can? :read,Vip



    #可以查看GoodsException就可以导出数据
    can :export_excel,GoodsException if can? :read,GoodsException

    #默认都可读取message信息
    can :read,Message
    can :update_view_count,Message

    #盘货统计
    can :before_new,BranchInventory if can? :create,BranchInventory
    can :before_new,YardInventory if can? :create,YardInventory
    can :search_bills,BranchInventory if can? :do_search_bills,BranchInventory
    can :search_bills,YardInventory if can? :do_search_bills,YardInventory

    #中转货物装车清单
    can :read_from_org,InnerTransitLoadList if can? :create_transit,InnerTransitLoadList
    can :create,InnerTransitLoadList if can? :create_transit,InnerTransitLoadList

    #中转返款单
    can :read_from_org,InnerTransitRefund if can? :create_from_org,InnerTransitRefund
    can :create,InnerTransitRefund if can? :create_from_org,InnerTransitRefund

    #可以查看goods_cat_fee_config,就可以export_excel
    can :export_excel,GoodsCatFeeConfig if can :read,GoodsCatFeeConfig

    #在库单据录入
    #可以批量录入,就可以创建与修改
    can :create,InStockBill if can? :batch_input,InStockBill
    #运价批量修改,
    can :copy_price,GoodsCatFeeConfig if can? :show_batch_adjust,GoodsCatFeeConfig
    #组织机构管理,可修改机构信息,就可设置到货地
    can :show_org_permits,Org if can? :edit,Org

    #代收货款支付清单导出为sms_excel
    can :export_sms_excel,TransferPaymentList if can? :read,TransferPaymentList
    can :export_sms_excel,OutterTransitTransferPaymentList if can? :read,OutterTransitTransferPaymentList
    can :export_sms_excel,SummaryOrgOutterTransitTransferPaymentList if can? :read,SummaryOrgOutterTransitTransferPaymentList
    can :export_sms_excel,SummaryOrgInnerTransitTransferPaymentList if can? :read,SummaryOrgInnerTransitTransferPaymentList
    can :export_sms_excel,LocalTownTransferPaymentList if can? :read,LocalTownTransferPaymentList

    #分理处分公司实提运费,查询功能
    can :search_fenlichu,CarryingFeeThRpt if can? :rpt_fenlichu,CarryingFeeThRpt
    can :search_fengongsi,CarryingFeeThRpt if can? :rpt_fengongsi,CarryingFeeThRpt

    #可打印提货单,就可以记录提货单打印次数
    can :th_bill_print_counter,CarryingBill if can? :print,DeliverInfo

    #可投票,就可保存投票信息
    can :save_vote,VoteConfig if can? :new_vote,VoteConfig
    can :show_vote_info,VoteConfig if can? :new_vote,VoteConfig
    can :current_user_vote_index,VoteConfig if can? :new_vote,VoteConfig

    can :save_vote,VoteConfigWithOrg if can? :new_vote,VoteConfigWithOrg
    can :show_vote_info,VoteConfigWithOrg if can? :new_vote,VoteConfigWithOrg
    can :current_user_vote_index,VoteConfigWithOrg if can? :new_vote,VoteConfigWithOrg

    can :save_vote,SingleVoteConfigWithOrg if can? :new_vote,SingleVoteConfigWithOrg
    can :show_vote_info,SingleVoteConfigWithOrg if can? :new_vote,SingleVoteConfigWithOrg
    can :current_user_vote_index,SingleVoteConfigWithOrg if can? :new_vote,SingleVoteConfigWithOrg



    #可查看rpt_from_org_mth,就可调用data
    can :data,RptFromOrgMth if can? :read,RptFromOrgMth
    can :data,RptFromOrgMth if can? :before_data_with_selected_mths,RptFromOrgMth

    #客户提款结算清单-批量转账确认
    can :batch_transfer,PostInfo if can? :transfer,PostInfo

    #任务管理
    can :show_audit_page,Task if can? :do_audit,Task

    can :save_progress,Task if can? :new_progress_page,Task
    can :save_finish,Task if can? :show_finish_page,Task

    #通知公告
    can :update_view_count,Message
    can :get_config,RegionDivideConfig

    #发货短途费申请
    can [:search_lines,:report_lines],FromShortFeeInfo if can? :read,FromShortFeeInfo

    #装卸工作量统计
    can :report_workload,ScanHeaderTeam if can? :read,ScanHeaderTeam
    can :report_workload,ScanHeaderSubBranch if can? :read,ScanHeaderSubBranch
  end

  #定义运单修改权限
  def set_bill_update_permission
    ability_org_ids = user.current_ability_org_ids
    #可修改20%运费
    if can? :update_carrying_fee_20,CarryingBill
      #重新设置运单不可修改
      cannot :update_carrying_fee_20,CarryingBill
      can :update_carrying_fee_20,CarryingBill do |bill|
        ori_carrying_fee = bill.original_carrying_fee
        ori_carrying_fee = bill.carrying_fee if ori_carrying_fee.blank?
        (ori_carrying_fee  > 0) ? ((ori_carrying_fee  - bill.carrying_fee)/ori_carrying_fee <= 0.2 and ability_org_ids.include?(bill.from_org_id) and ['billed','loaded','shipped','reached','distributed'].include?(bill.state)) : true
      end
    end
    #可修改50%运费
    if can? :update_carrying_fee_50,CarryingBill
      cannot :update_carrying_fee_50,CarryingBill
      can :update_carrying_fee_50,CarryingBill do |bill|
        ori_carrying_fee = bill.original_carrying_fee
        ori_carrying_fee = bill.carrying_fee if ori_carrying_fee.blank?
        (ori_carrying_fee > 0) ? ((ori_carrying_fee - bill.carrying_fee)/ori_carrying_fee  <= 0.5 and ability_org_ids.include?(bill.from_org_id) and ['billed','loaded','shipped','reached','distributed'].include?(bill.state)) : true
      end
    end
    #可修改100%运费
    if can? :update_carrying_fee_100,CarryingBill
      cannot :update_carrying_fee_100,CarryingBill
      can :update_carrying_fee_100,CarryingBill do |bill|
        ability_org_ids.include?(bill.from_org_id) and ['billed','loaded','shipped','reached','distributed'].include?(bill.state)
      end
    end
  end
end

