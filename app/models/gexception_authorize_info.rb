# -*- encoding : utf-8 -*-
class GexceptionAuthorizeInfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :goods_exception

  default_value_for :bill_date do
    Date.today
  end
  validates_presence_of :goods_exception_id,:bill_date,:op_type
  validates_numericality_of :compensation_fee


  #赔偿方式
  COMPENSATE_TYPE_NOPAY = 'NP'
  COMPENSATE_TYPE_FROM_ORG = 'FO'
  COMPENSATE_TYPE_TO_ORG = 'TO'
  COMPENSATE_TYPE_HEADQUARTERS = 'HP'
  #双方分摊
  COMPENSATE_TYPE_FROM_AND_TO = 'FT'
  #赔偿方式描述
  def self.op_types
    {
      "免赔" => COMPENSATE_TYPE_NOPAY,
      "发货站处理" => COMPENSATE_TYPE_FROM_ORG,
      "到货站处理" => COMPENSATE_TYPE_FROM_ORG,
      "双方分摊" => COMPENSATE_TYPE_FROM_AND_TO,
      "总部处理" => COMPENSATE_TYPE_HEADQUARTERS
    }
  end
end
