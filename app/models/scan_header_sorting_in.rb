#coding: utf-8
#分拣组入库单
class ScanHeaderSortingIn < ScanHeader
  #定义状态机
  state_machine :initial => :draft do
    after_transition do |sh,transition|
      sh.carrying_bills.update_all("state='sorted_in'","state = 'billed'")
    end
    event :process do
      #草稿->已分拣
      transition :draft => :sorted_in
    end
  end
end
