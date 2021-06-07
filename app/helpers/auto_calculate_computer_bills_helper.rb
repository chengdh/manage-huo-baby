#coding: utf-8
module AutoCalculateComputerBillsHelper
  def cache_key_for_goods_cats
    count = GoodsCat.count
    max_updated_at = GoodsCat.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "goods-cats/all-#{count}-#{max_updated_at}"
  end
end
