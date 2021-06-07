#coding: utf-8
#分理处盘货清单
class BranchInventory < ActLoadList
  has_many :inventory_moves,:foreign_key => :inventory_id
  validates_presence_of :from_org_id,:to_org_id
  after_create :create_inventory_move
  #定义状态机
  state_machine :initial => :billed do
    #分理处发货
    after_transition :billed => :shipped do |inventory,transition|
      inventory.inventory_move_shipped
    end
    #货场确认
    after_transition :checked => :reached do |inventory,transition|
      inventory.inventory_move_reached
    end

    event :process do
      transition :billed => :shipped,:checked => :reached
    end
    #到货检查
    event :check do
      transition :shipped => :checked
    end
  end

  #生成分理处-货场盘货记录
  def create_inventory_move
    lines = self.act_load_list_lines
    self.act_load_list_lines.each do |l|
      inventory = InventoryMove.create(:inventory => self,:carrying_bill_id => l.carrying_bill_id,:from_org_id => self.from_org_id,:to_org_id => self.to_org_id,:qty => l.load_num,:state => 'billed')
    end
  end

  #发货处理
  def inventory_move_shipped
    inventory_move_ids = self.inventory_move_ids
    #更新所有库存移动信息为已到货状态
    InventoryMove.update_all({:state => 'shipped'},:id => inventory_move_ids)

    #FIXME 20140717 因取消夜班,添加自动到货处理
    #发货;到货检查;收货
    process;check;process;
  end

  #到货地验货
  def inventory_move_reached
    inventory_move_ids = self.inventory_move_ids
    #更新所有库存移动信息为已到货状态
    InventoryMove.update_all({:state => 'reached'},:id => inventory_move_ids)
    #产生发货与到货的差额
    self.act_load_list_lines.each do |l|
      #NOTE 目前是自动到货确认,确认数量等于装车数量
      #实际使用时,#55行代码需要删除掉
      l.update_attributes(:confirm_num => l.load_num)
      if l.confirm_num < l.load_num
        InventoryMove.create(:inventory => self,:carrying_bill_id => l.carrying_bill_id,:from_org_id => self.from_org_id,:to_org_id => self.to_org_id,:qty => (l.confirm_num - l.load_num),:state => 'reached')
      end
    end
  end
end
