#coding: utf-8
module ReportModule
  #简单查询,用于报表统计
  def simple_search
    @search = resource_class.search(params[:search])
  end
  #简单查询,按照录入时间
  def simple_search_with_created_at
    @search = resource_class.search(params[:search])
  end

  #日/月营业额统计
  def rpt_turnover
    cur_org = current_user.default_org
    @search = resource_class.where(:from_org_id => current_user.current_ability_org_ids).turnover.search(params[:search])
    @carrying_bills = @search.all
    #get_collection_ivar || set_collection_ivar(@search.all)
  end

  #按照装卸组权限进行日/月营业额统计
  def rpt_turnover_by_org_load
    cur_org = current_user.default_org
    # if cur_org.in_summary?
    #   @search = resource_class.where(:from_org_id => current_user.current_ability_org_ids).turnover.search(params[:search])
    # else
    #   @search = resource_class.where(:from_org_id => current_user.current_ability_org_ids).turnover.search(params[:search])
    # end

    @search = resource_class.where(:from_org_id => Org.department_list_ids).turnover.search(params[:search])
    if cur_org.respond_to?(:org_ids)
      @carrying_bills = @search.relation.search(:to_org_id_in => cur_org.try(:org_ids)).all
    else
      @carrying_bills = @search.all
    end
  end

  #返程票日/月营业额统计
  def rpt_turnover_for_refund
    @search = resource_class.where(:to_org_id => current_user.current_ability_org_ids).turnover.search(params[:search])
    @carrying_bills = @search.all
  end

  #内部中转-日/月营业额统计
  def rpt_turnover_for_inner_transit_bill
    @search = resource_class.where(:type => ['InnerTransitBill','HandInnerTransitBill','InnerTransitReturnBill'],:transit_org_id => current_user.current_ability_org_ids).turnover.search(params[:search])
    @carrying_bills = @search.all
  end

  #未提货金额汇总表
  def rpt_no_delivery
    @search = resource_class.where(:from_org_id => current_user.current_ability_org_ids).rpt_no_delivery.search(params[:search])
    @carrying_bills = @search.all
  end
  #始发地收货营业额统计,用于统计其他分理处/分公司发到本地的货物汇总信息
  def rpt_turnover_by_from_org
    #FIXME 此处未统计内部中转票
    @search = resource_class.where(:to_org_id => current_user.current_ability_org_ids).turnover.search(params[:search])
    @carrying_bills = @search.all
  end

  #营业额统计柱状图
  def turnover_chart
    @search = resource_class.where(:from_org_id =>current_user.current_ability_org_ids).turnover.search(params[:search])
    @carrying_bills = @search.all
  end
  #货款出入情况
  def sum_goods_fee_inout
    @sum_goods_fee_in = resource_class.sum_goods_fee_in(current_user.current_ability_org_ids,params[:date_from] || Date.today.beginning_of_month,params[:date_to] || Date.today.end_of_month).search(params[:search]).all
    @sum_goods_fee_out = resource_class.sum_goods_fee_out(current_user.current_ability_org_ids,params[:date_from] || Date.today.beginning_of_month,params[:date_to] || Date.today.end_of_month).search(params[:search]).all
  end

  #显示多运单查询界面
  #GET carrying_bills/multi_bills_search
  def multi_bills_search ; end

  #显示按照客户编号查询运单界面
  #GET /carrying_bills/customer_code_search
  def customer_code_search ; end

  #分公司分成报表
  #NOTE 使用POST是为了避免request-uri too large的问题
  #POST /carrying_bills/rpt_divide
  def rpt_divide
    to_org_ids = params[:search].try("[]",:to_org_id_in)
    from_org_ids = params[:search].try("[]",:from_org_id_in)
    deliver_info_bill_date_gte = params[:search].try(:fetch,:deliver_info_deliver_date_gte)
    deliver_info_bill_date_lte = params[:search].try(:fetch,:deliver_info_deliver_date_lte)
    @search = resource_class.where(:to_org_id => Org.branch_list_ids(nil,true)).sum_deliveried_bills(from_org_ids,to_org_ids,deliver_info_bill_date_gte,deliver_info_bill_date_lte).search
    @carrying_bills = @search.all
  end

  #分理处分成报表
  #NOTE 使用POST是为了避免request-uri too large的问题
  #POST /carrying_bills/rpt_divide_department
  def rpt_divide_department
    from_org_ids = params[:search].try("[]",:from_org_id_in)
    to_org_ids = params[:search].try("[]",:to_org_id_in)

    deliver_info_bill_date_gte = params[:search].try(:fetch,:deliver_info_deliver_date_gte)
    deliver_info_bill_date_lte = params[:search].try(:fetch,:deliver_info_deliver_date_lte)
    @search = resource_class.where(:from_org_id => Org.department_list_ids).sum_deliveried_bills_by_from_org(from_org_ids,to_org_ids,deliver_info_bill_date_gte,deliver_info_bill_date_lte).search
    @carrying_bills = @search.all
  end
  #提货分公司管控报表
  #POST /carrying_bills/rpt_branch_mc_1
  #使用POST防止参数过长
  def rpt_branch_mc_1
    to_org_ids = [] if params[:search].blank? or params[:search][:to_org_id_in].blank?
    to_org_ids = params[:search].delete(:to_org_id_in) if params[:search].present? and params[:search][:to_org_id_in].present?
    @carrying_bills = Deposit.rpt_branch_mc_1(current_user.current_ability_org_ids,to_org_ids,params[:search])
  end

  #预付分公司管控报表
  #POST /carrying_bills/rpt_branch_mc_2
  #使用POST防止参数过长
  def rpt_branch_mc_2
    to_org_ids = [] if params[:search].blank? or params[:search][:to_org_id_in].blank?
    to_org_ids = params[:search].delete(:to_org_id_in) if params[:search].present? and params[:search][:to_org_id_in].present?
    @carrying_bills = Deposit.rpt_branch_mc_2(current_user.current_ability_org_ids,to_org_ids,params[:search])
  end
end
