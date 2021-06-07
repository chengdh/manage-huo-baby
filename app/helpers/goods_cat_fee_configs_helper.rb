#coding: utf-8
module GoodsCatFeeConfigsHelper
  #货物分类运费设置
  def goods_cat_fee_configs_for_select
    GoodsCatFeeConfig.where(:is_active => true).map {|gfc| ["#{gfc.from_org}~#{gfc.to_org}",gfc.id]}
  end
end
