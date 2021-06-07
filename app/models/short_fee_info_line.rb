# -*- encoding : utf-8 -*-
class ShortFeeInfoLine < ActiveRecord::Base
  belongs_to :short_fee_info
  belongs_to :carrying_bill
end

