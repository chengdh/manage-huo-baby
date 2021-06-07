#coding: utf-8
#货场盘货清单
class YardInventory < ActLoadList
  has_many :inventory_moves,:foreign_key => :inventory_id
  validates_presence_of :from_org,:to_org_id
  after_create :create_inventory_move
  #定义状态机
  state_machine :initial => :billed do
    #货场发货
    after_transition :billed => :shipped do |inventory,transition|
      inventory.inventory_move_shipped
    end
    #到货地验货
    after_transition :checked => :reached do |inventory,transition|
      inventory.inventory_move_reached
    end

    event :process do
      transition :billed =>:shipped,:checked => :reached
    end
    #到货检查
    event :check do
      transition :shipped => :checked
    end
  end
  #导出sms群发文本
  def to_sms_txt(ids = {})
    #去除固定电话和空号
    sms_bills = self.carrying_bills.find(ids).find_all {|bill| bill.sms_mobile_for_arrive.present? }
    no_mobile_sms_bills = self.carrying_bills.find(ids).find_all {|bill| bill.sms_mobile_for_arrive.blank? }
    group_sms_bills = sms_bills.group_by(&:sms_mobile_for_arrive)
    #分别合计货物件数/运费合计/货款合计
    sms_text = ''
    group_sms_bills.each do |key,bills|
      goods_num = bills.to_a.sum(&:goods_num)
      goods_nos = []
      bills.each do |the_bill|
        goods_nos << the_bill.goods_no[6..-1]
      end
      goods_fee = bills.to_a.sum(&:th_amount).to_i
      sms_text += Settings.notice_arrive.sms_batch % [key,self.to_org.try(:name),goods_nos.join(" "),goods_fee,self.to_org.try(:location),self.to_org.try(:phone)]
    end
    sms_text +="===============================以下运单无手机号===============================================\r\n"
    no_mobile_sms_bills.each do |bill|
      goods_no = bill.goods_no[6..-1]
      sms_text += Settings.notice_arrive.sms_batch % [bill.try(:phone_or_mobile_for_arrive),self.to_org.try(:name),goods_no,bill.th_amount,self.to_org.try(:location),self.to_org.try(:phone)]
    end
    sms_text
  end

  #发货后,生成库存移动记录
  def create_inventory_move
    self.act_load_list_lines.each do |l|
      inventory = InventoryMove.create(:inventory => self,:carrying_bill_id => l.carrying_bill_id,:from_org_id => self.from_org_id,:to_org_id => self.to_org_id,:qty => l.load_num,:state => 'billed')
    end
  end
  #发货处理
  def inventory_move_shipped
    inventory_move_ids = self.inventory_move_ids
    #更新所有库存移动信息为已到货状态
    InventoryMove.update_all({:state => 'shipped'},:id => inventory_move_ids)
  end

  #到货地验货
  def inventory_move_reached
    inventory_move_ids = self.inventory_move_ids
    #更新所有库存移动信息为已到货状态
    InventoryMove.update_all({:state => 'reached'},:id => inventory_move_ids)
    #产生发货与到货的差额
    self.act_load_list_lines.each do |l|
      if l.confirm_num < l.load_num
        inventory = InventoryMove.create(:inventory => self,:carrying_bill_id => l.carrying_bill_id,:from_org_id => self.from_org_id,:to_org_id => self.to_org_id,:qty => (l.confirm_num - l.load_num),:state => 'reached')
      end
    end
  end
end
