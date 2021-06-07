#coding: utf-8
#同城快递-结算员交款清单
class LocalTownSettlement < BaseSettlement
  #自动生成结算员交款清单
  def self.auto_generate_settlement
    admin = User.first
    #只是生成分理处及一级分公司的结算员交款清单
    orgs = Org.department_list

    orgs.each do |b|
      bills = CarryingBill.where(:to_org_id => b.id ,:state => 'deliveried',:type => ['LocalTownBill', 'HandLocalTownBill'],:completed => false )
      if bills.present?
        bill_ids = bills.map {|bill| bill.id}
        settlement = LocalTownSettlement.new(:bill_date => Date.today,:org_id => b.id,:user_id => admin.id,:note => "系统自动生成结算清单")
        settlement.carrying_bill_ids = bill_ids
        #处理结算清单
        settlement.process
      end
    end
  end

end
