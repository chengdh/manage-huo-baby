module GoodsCatsHelper
  #货物大类选择
  def parent_goods_cats_for_select
    GoodsCat.search(:is_active_eq => true,:parent_id_is_null => true).order('order_by ASC').map {|cat| ["#{cat.name}(#{cat.easy_code})",cat.id]}
  end
  #货物分类
  def goods_cats_for_select
    GoodsCat.search(:is_active_eq => true,:parent_id_is_not_null => true ).order('parent_id ,order_by ASC').map {|gc| ["#{gc.name}(#{gc.easy_code})",gc.id]}
  end
  #放置到界面上的goods_cats属性,data-goods_cats
  def goods_cats_for_data_json
    GoodsCat.search(:is_active_eq => true,:parent_id_is_not_null => true ).order('parent_id ,order_by ASC').to_json(:methods => [:goods_cat_promotions,:parent])
  end

end
