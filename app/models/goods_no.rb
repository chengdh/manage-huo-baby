# -*- encoding : utf-8 -*-
#货号生成器
class GoodsNo < ActiveRecord::Base
  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  #生成新的货号
  def self.gen_goods_no(bill)
    if bill.from_org_id.blank?
      return nil
    end
    if ["ComputerBill","AutoCalculateComputerBill","HandBill","ReturnBill","LocalTownBill","HandLocalTownBill"].include? bill.type and bill.to_org_id.blank?
      return nil
    end
    if ["InnerTransitBill","HandInnerTransitBill","TransitBill","HandTransitBill"].include? bill.type and bill.transit_org_id.blank?
      return nil
    end

    from_org = bill.from_org
    to_org = bill.to_org
    #外部中转运单
    to_org =  bill.transit_org if ["TransitBill","HandTransitBill"].include? bill.type
    to_area = bill.area

    goods_no = GoodsNo.find_or_create_by_from_org_id_and_to_org_id_and_gen_date(from_org.id,to_org.id,bill.bill_date)
    #删除以往数据
    GoodsNo.destroy_all(["from_org_id = ? AND to_org_id = ? AND gen_date < ? ",from_org.id,to_org.id,bill.bill_date])
    GoodsNo.increment_counter(:bill_count,goods_no.id)

    goods_no_str = "#{bill.bill_date.strftime('%y%m%d')}#{from_org.simp_name}#{to_org.simp_name}#{to_area.try(:simp_name)}#{goods_no.reload.bill_count}-#{bill.goods_num}"
  end
end
