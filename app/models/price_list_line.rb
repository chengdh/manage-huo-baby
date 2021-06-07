#coding: utf-8
#分公司运价明细
class PriceListLine < ActiveRecord::Base
  belongs_to :price_list
  belongs_to :fee_unit
  validates :fee_unit_id, presence: true
  validates :price,:min_price,:divide_rate, numericality: true

  #根据传入的参数获取运价设置信息
  #传入的参数有三个:
  #search[price_list_org_id_eq] 分公司id
  #search[fee_unit_id_eq] 计量单位id
  #计算方法：
  #1 先精确查询匹配
  #2 如果找不到,则按照fee_unit中的default_price计算
  def self.search_line(params)
    price_line = nil
    return nil if params[:search].blank? or params[:search]['price_list_org_id_eq'].blank? or params[:search]['fee_unit_id_eq'].blank?
    price_line = self.search(params[:search]).try(:first)
    if price_line.blank?
      fee_unit = FeeUnit.find(params[:search]['fee_unit_id_eq'])
      price_line = PriceListLine.new(:fee_unit => fee_unit,
                                     :price => fee_unit.default_price,
                                     :min_price => fee_unit.default_price
                                    )
    end
    price_line
  end
end
