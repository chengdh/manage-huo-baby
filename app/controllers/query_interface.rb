#coding: utf-8
module QueryInterface

  #外部查询服务界面
  def search_serviece_page ; end

  #外部查询结果界面
  def search_service
    if params[:bill_nos].blank?
      render :action => :search_service_page
      return
    else
      bill_nos = params[:bill_nos].split(',')
      @carrying_bills = CarryingBill.search(:bill_date_gte => 3.months.ago).where(:bill_no => bill_nos)
    end
    respond_to do |format|
      format.html
      format.xml {render :xml => @carrying_bills.to_xml(:skip_types => true,:dasherize => false)}
    end
  end

  #单票查询服务界面
  def single_search_service_page ; end
  #单票查询结果
  def single_search_service
    if params[:bill_no].blank?
      render :action => :single_search_service_page
      return
    else
      @carrying_bill = CarryingBill.search(:bill_date_gte => 3.months.ago).relation.find_by_bill_no(params[:bill_no])
    end
    respond_to do |format|
      format.html
      format.xml {render :xml => @carrying_bills.to_xml(:skip_types => true,:dasherize => false)}
    end
  end

  #按照客户卡号查询
  def search_service_page_by_customer_code ; end

  #单票查询结果
  def search_service_by_customer_code
    @carrying_bills = CarryingBill.search(:bill_date_gte => 3.months.ago).relation.search(params[:search]).relation
    respond_to do |format|
      format.html
      format.xml {render :xml => @carrying_bills.to_xml(:skip_types => true,:dasherize => false)}
    end
  end
end
