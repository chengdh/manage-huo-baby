#coding: utf-8
#分理处装车
class ScanHeaderSubBranch < ScanHeader
  state_machine :initial => :draft do
    after_transition do |sh,transition|
      # sh.carrying_bills.each {|bill| bill.standard_process if bill.state.eql?("billed")}
    end
    event :process do
      #草稿->已装车
      transition :draft => :shipped
    end
  end

  #发车
  def ship
    update_attributes(:state => :shipped)
  end
end
