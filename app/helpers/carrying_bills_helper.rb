# -*- encoding : utf-8 -*-
module CarryingBillsHelper
  #运费支付方式显示
  def pay_type_des(pay_type)
    pay_type_des = ""
    CarryingBillExtend::PayType::pay_types.each {|des,code| pay_type_des = des if code == pay_type }
    pay_type_des
  end
  #票据状态
  def states_for_select
    CarryingBill.state_machine.states.collect{|state| [state.human_name,state.value] }
  end

  #附加状态
  def additional_states_for_select
    CarryingBill.state_machines[:additional_state].states.collect{|state| [state.human_name,state.value] }
  end

  #短途运费状态
  def short_fee_states_for_select
    CarryingBill.state_machines[:from_short_fee_state].states.collect{|state| [state.human_name,state.value] }
  end

  #得到查询对象的id数组
  def search_ids
    @search.select("carrying_bills.id,carrying_bills.from_org_id").map {|bill| bill.id }.to_json
  end
  #得到票据合计信息
  def search_sum
    sum_info = CarryingBill.search_sum(@search)
    sum_info
  end
  #得到滞留天数对应的class
  def stranded_class(days)
    ret_class=''
    #1-4天 正常
    #5-8天 绿色
    #9-12天 黄色
    #13-15天 红色
    #16天以上 黑色
    ret_class="white-bill" if days >= 1 and days <= 4
    ret_class="green-bill" if days >= 5 and days <= 8
    ret_class="yellow-bill" if days >= 9 and days <= 12
    ret_class="red-bill" if days >= 13 and days <= 15
    ret_class="black-bill" if days >= 16
    ret_class
  end
  #生成show_fields/hide_fields css selector
  def gen_fields_selector(fields_selector="",show=true)
    css_array=[]
    css_array << (show ? params[:show_fields] : params[:hide_fields]) << fields_selector
      css_array.delete_if {|x| x.blank?}
    css_array.join(",")
  end
  #设置运单修改权限
  def get_bill_update_class(resource)
    can_update =[]
    #billed loaded状态下,运单可修改全部信息
    if can?(:update_all,resource)
      can_update << 'update_all'
    else

      #提货前,运单可修改运费及货款
      can_update <<  'update_carrying_fee' if ['billed','loaded','shipped','reached','distributed'].include?(resource.state) and can?(:update_carrying_fee_20,resource) or can?(:update_carrying_fee_50,resource) or can?(:update_carrying_fee_100,resource)
      can_update << 'update_goods_fee' if ['billed','loaded','shipped','reached','distributed'].include?(resource.state) and can?(:update_goods_fee,resource)
    end
    can_update=[] if resource.new_record?
    #得到是否可修改运单日期
    #可修改运单日期:返回edit_bill_date
    can_update << 'edit_bill_date' if can?(:edit_bill_date,resource)

    can_update.join(' ')
  end
  #打印次数
  def print_counter_for_select
    [["打印多次",2]]
  end
  #运单类型
  def bill_types_for_select
    [
      ["机打运单","ComputerBill"],["机打运单-自动计算","AutoCalculateComputerBill"],
      ["手工运单","HandBill"],["中转运单","TransitBill"],["手工中转运单","HandTransitBill"],
      ["退货单","ReturnBill"]
    ]
  end
  def bill_types
    #NOTE 去除了内部中转运单和外部中转运单
    CarryingBill::BILL_TYPES - ['TransitBill','HandTransitBill','InnerTransitBill','HandInnerTransitBill','LocalTownBill','HandLocalTownBill']
  end
  #运单导出为json包含的methods数组
  def bill_to_json_methods
    {:methods => [:from_org,:transit_org,:to_org,:from_to_description,:pay_type_des,:carrying_fee_th,:k_carrying_fee,:carrying_fee_total,
                  :carrying_fee_th_total,
                  :k_carrying_fee_total,:agent_carrying_fee,:act_pay_fee,:insured_fee,:insured_fee_th,
                  :k_insured_fee,:from_short_carrying_fee,:from_short_carrying_fee_th,:k_from_short_carrying_fee,
                  :to_short_carrying_fee,:to_short_carrying_fee_th,:k_to_short_carrying_fee,:is_qrcode_pay,:from_customer_qrcode,
                  :th_amount,:send_state,:from_short_fee_saved?,:to_short_fee_saved?,:stranded_days,:is_debt_bill,
                  :deliver_region,:is_receipt_des]}
  end

  #运单号长度 同城快运运单长度为10，其他为7
  def bill_no_length(bill_type)
    bill_no_length = 7
    bill_no_length = 10 if ["LocalTownBill","HandLocalTownBill"].include?(bill_type)
    bill_no_length
  end

  #外部查询服务界面票据状态选择
  def search_service_bill_states_for_select
    [["未提货","no_deliveried"],["已提货","deliveried_no_paid"],["已提款","paid"],["全部",""]]
  end

  #带回单描述信息
  def receipt_des(is_receipt)
    ret = ""
    ret = "带回单" if is_receipt
    ret
  end
end

