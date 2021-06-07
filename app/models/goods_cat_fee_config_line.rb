#coding: utf-8
#货物分类费用设置明细
class GoodsCatFeeConfigLine < ActiveRecord::Base
  belongs_to :goods_cat_fee_config,:touch => true
  belongs_to :goods_cat
  validates :goods_cat,:presence => true
  #根据传入的参数获取运费计算设置信息
  #传入的参数有三个:
  #search[goods_cat_fee_config_from_org_id_eq] 发货地id
  #search[goods_cat_fee_config_to_org_id_eq] 到货地id
  #search[goods_cat_id_eq] 货物分类明细ic
  #计算方法：
  #1 先精确查询匹配
  #2 如果找不到,按照发货地上级机构Id + 到货地id进行查询
  #3 如果找不到,按照到货地上级机构Id + 到货地上级机构id查询
  #4 如果仍然查不到,则返回空
  def self.search_line(params)
    config_line = nil
    return nil if params[:search].blank? or params[:search]['goods_cat_fee_config_from_org_id_eq'].blank? or params[:search]['goods_cat_fee_config_to_org_id_eq'].blank? or params[:search][:goods_cat_id_eq].blank?
    the_from_org = Org.find(params[:search]['goods_cat_fee_config_from_org_id_eq'])
    the_to_org = Org.find(params[:search]['goods_cat_fee_config_to_org_id_eq'])
    config_line = self.search(params[:search]).try(:first)
    if config_line.blank? and the_from_org.parent_id.present?
      params[:search]['goods_cat_fee_config_from_org_id_eq'] = the_from_org.parent_id
      config_line = self.search(params[:search]).try(:first)
    end
    if config_line.blank? and the_to_org.parent_id.present?
      params[:search]['goods_cat_fee_config_to_org_id_eq'] = the_to_org.parent_id
      config_line = self.search(params[:search]).try(:first)
    end
    if config_line.blank?
      goods_cat = GoodsCat.find(params[:search]['goods_cat_id_eq'])
      config_line = GoodsCatFeeConfigLine.new(:goods_cat => goods_cat,:unit_price => goods_cat.default_price,:bottom_price => goods_cat.default_price)
    end
    config_line
  end

  def goods_cat_name
    self.goods_cat.try(:name)
  end
end
