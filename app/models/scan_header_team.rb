#coding: utf-8
#公司内部装卸组入库
class ScanHeaderTeam < ScanHeader
  #定义状态机
  state_machine :initial => :draft do
    # after_transition do |sh,transition|
    #   sh.carrying_bills.update_all("state='loaded_in'","state = 'billed'")
    # end
    event :process do
      #草稿->装卸组入库
      transition :draft => :loaded_in
    end
  end
end
