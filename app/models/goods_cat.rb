#coding: utf-8
require 'ruby-pinyin/pinyin'
class GoodsCat < ActiveRecord::Base
  acts_as_tree :order => :order_by
  #default_scope includes(:goods_cat_promotions)
  validates :name,:presence => true
  validates_numericality_of :default_price
  has_many :goods_cat_promotions,:dependent => :destroy
  has_many :goods_cat_fee_config_lines,:dependent => :destroy
  accepts_nested_attributes_for :goods_cat_promotions
  #FIXME 此处有性能问题
  #after_initialize :build_goods_cat_promotions
  before_save :gen_py
  after_create :create_goods_cat_fee_config_line
  default_value_for :default_price,5
  private
  def build_goods_cat_promotions
    (10 - self.goods_cat_promotions.size).times { self.goods_cat_promotions.build }
  end
  def gen_py
    py = PinYin.instance
    self.easy_code = py.to_pinyin_abbr(self.name)
  end
  #新增货物分类时,goods_cat_fee_config_lines中增加该分类
  def create_goods_cat_fee_config_line
    GoodsCatFeeConfig.all.each do |gfc|
      gfcl = GoodsCatFeeConfigLine.find_or_create_by_goods_cat_fee_config_id_and_goods_cat_id(gfc.id,self.id)
      gfcl.update_attributes(:unit_price => self.default_price)
    end
  end
end
