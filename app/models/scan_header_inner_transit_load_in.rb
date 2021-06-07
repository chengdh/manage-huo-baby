#coding: utf-8
#内部中转-总部装卸组入库
class ScanHeaderInnerTransitLoadIn < ScanHeader
  #定义状态机
  state_machine :initial => :draft do
    after_transition do |sh,transition|
      sh.carrying_bills.update_all("state='inner_transit_loaded_in'","state = 'billed'")
    end
    event :process do
      #草稿->装卸组入库
      transition :draft => :inner_transit_loaded_in
    end
  end
end
