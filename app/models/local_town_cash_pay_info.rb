#coding: utf-8
#同城快运-客户提款(现金)
class LocalTownCashPayInfo < BaseCashPayInfo
  belongs_to :bank
  validates :account_name,:account_no,:mobile, :presence => true
  validates :account_no,:format => {:with => /^\d{16}$|^\d{19}$/}
  validates :mobile, :length => {:is => 11}

  #删除前先回复关联运单状态
  before_destroy :set_carrying_bills_to_payment_listed
  private
  def set_carrying_bills_to_payment_listed
    #将关联运单状态修改为付款前状态
    self.carrying_bills.update_all(:state =>:payment_listed,:pay_info_id => nil)
  end
end
