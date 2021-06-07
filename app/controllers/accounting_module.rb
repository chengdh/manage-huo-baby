#coding: utf-8
module AccountingModule
  #始发货现金付凭证
  #该凭证自运费货款统计中生成
  #GET carrying_bills/build_accounting_document_from_cash
  def build_accounting_document_from_cash
    @cr_lines,@dr_lines,@cr_detail_lines,@dr_detail_lines,@context = resource_class.build_accounting_document_from_cash(params[:search],{:note_date => params[:search][:bill_date_gte]})
  end
  #始发货提付凭证
  #该凭证从收款清单中生成
  #GET carrying_bills/build_accounting_document_from_th
  def build_accounting_document_from_th
    refound = Refound.find(params[:search][:refound_id_in].first)
    ctx = {:note_date => refound.bill_date.strftime("%Y-%m-%d"),:org_name => refound.from_org.simp_name}
    @cr_lines,@dr_lines,@cr_detail_lines,@dr_detail_lines,@context = resource_class.build_accounting_document_from_th(params[:search],ctx)
  end


  #返程货提付凭证
  #该凭证从结算员交款清单中生成
  #GET carrying_bills/build_accounting_document_to_th
  def build_accounting_document_to_th
    settlement = Settlement.find(params[:search][:settlement_id_eq])
    ctx = {:note_date => settlement.bill_date.strftime("%Y-%m-%d"),:org_name => settlement.org.simp_name}
    @cr_lines,@dr_lines,@cr_detail_lines,@dr_detail_lines,@context = 
      resource_class.build_accounting_document_to_th(params[:search],ctx)
  end

  #返程货现付凭证
  #自返程货票据统计中生成
  #GET carrying_bills/build_accounting_document_to_cash
  def build_accounting_document_to_cash
    ctx = {:note_date => params[:search][:load_list_reached_date_gte]}
    @cr_lines,@dr_lines,@cr_detail_lines,@dr_detail_lines,@context = 
      resource_class.build_accounting_document_to_cash(params[:search],ctx)
  end

  #转账-代收货款支付清单凭证
  #GET carrying_bills/build_accounting_document_transfer_payment_list
  def build_accounting_document_transfer_payment_list
    ctx = {}
    @cr_lines,@dr_lines,@cr_detail_lines,@dr_detail_lines,@context = 
      resource_class.build_accounting_document_transfer_payment_list(params[:search],ctx)
  end
end
