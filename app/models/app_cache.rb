# -*- encoding : utf-8 -*-
#系统启动时,缓存相关数据
class AppCache
  #生成货号
  def self.gen_goods_no(bill)
    goods_no = "#{bill.bill_date.strftime('%y%m%d')}#{bill.from_org.simp_name}#{bill.transit_org.present? ? bill.transit_org.simp_name : bill.to_org.simp_name}#{get_seq(bill)}-#{bill.goods_num}"
  end

  #生成票号
  def self.gen_bill_no
    cur_bill_count = get_bill_count
    "%07d" % cur_bill_count
  end
  private
  #缓存指定日期/发货地/到货地(中转地)的运单数量
  #bill 给定的参照bill
  def self.get_seq(bill)
    #先查找当日是否已缓存
    seq = 0
    seq_key = ""
    if bill.transit_org.present?
      seq_key = "#{bill.bill_date.strftime('%y%m%d')}_#{bill.from_org_id}_#{bill.transit_org_id}_transit_seq"
      seq = Rails.cache.read(seq_key)
      #如果当日没有缓存
      if seq.blank?
        seq = CarryingBill.where(:bill_date => bill.bill_date,:from_org_id => bill.from_org_id,:transit_org_id => bill.transit_org_id).count + 1
      end
    else
      seq_key = "#{bill.bill_date.strftime('%y%m%d')}_#{bill.from_org_id}_#{bill.to_org_id}_seq"
      seq = Rails.cache.read(seq_key)
      #如果当日没有缓存
      if seq.blank?
        seq = CarryingBill.where(:bill_date => bill.bill_date,:from_org_id => bill.from_org_id,:to_org_id => bill.to_org_id).count + 1
      end
    end
    #删除以往缓存
    #FIXME 此处有问题
    cache_date = bill.bill_date.strftime('%y%m%d')
    #Rails.cache.delete_matched(/[^(#{Regexp.escape(cache_date)})]*\w+seq/)
    #Rails.cache.delete_matched(/[^(110708)]*\w+seq/)
    Rails.cache.write(seq_key,seq + 1)
    seq
  end
  #生成票据数量
  def self.get_bill_count
    cur_bill_count = Rails.cache.read("bill_count")
    if cur_bill_count.blank?
      #获取机打运单的数量
      #机打运单从4000000开始
      cur_bill_count = 4000000 + CarryingBill.where(:type => ["ComputerBill","TransitBill"]).count
    end

    cur_bill_count += 1
    Rails.cache.write('bill_count',cur_bill_count)
    cur_bill_count
  end
end

