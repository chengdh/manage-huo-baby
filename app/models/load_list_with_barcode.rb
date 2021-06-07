#coding: utf-8
#基于条形码的装车清单对象
class LoadListWithBarcode < ActiveRecord::Base
  #分理处及分公司发货
  OP_BRANCH_OUT = "branch_out";
  #货场收货
  OP_YARD_IN = "yard_in";
  #货场确认
  OP_YARD_CONFIRM = "yard_confirm";
  #货场发车
  OP_YARD_OUT = "yard_out";
  #分理处分公司入库
  OP_BRANCH_IN = "branch_in";

  #分理处及分公司确认
  OP_BRANCH_CONFIRM = "branch_confirm";

  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  belongs_to :user
  belongs_to :confirmer,:class_name => "User"
  has_many :load_list_with_barcode_lines
  accepts_nested_attributes_for :load_list_with_barcode_lines
  validates_presence_of :from_org_id,:to_org_id

  #到货场的发货操作
  def self.to_yard_op_types
    [OP_BRANCH_OUT,OP_YARD_IN,OP_YARD_CONFIRM]
  end

  #自货场发到分理处及分公司的操作
  def self.to_branch_op_types
    [OP_YARD_OUT,OP_BRANCH_IN,OP_BRANCH_CONFIRM]
  end

  def self.is_to_yard_op?(op_type)
    LoadListWithBarcode.to_yard_op_types.include?(op_type)
  end

  def self.is_to_branch_op?(op_type)
    LoadListWithBarcode.to_branch_op_types.include?(op_type)
  end


  #如果没有盘货清单,则自动创建一个
  #如果有,则更新原有数据

  def self.generate_inventory(bill_date,from_org_id,to_org_or_yard_id,op_type)
    logger.debug("LoadListWithBarcode#generate_inventory op_type=#{op_type}")
    logger.debug("LoadListWithBarcode#generate_inventory bill_date=#{bill_date}")
    logger.debug("LoadListWithBarcode#generate_inventory from_org_id=#{from_org_id}")
    logger.debug("LoadListWithBarcode#generate_inventory to_org_id=#{to_org_or_yard_id}")
    inventory_clazz = BranchInventory if is_to_yard_op?(op_type)
    inventory_clazz = YardInventory if is_to_branch_op?(op_type)

    # return unless is_to_yard_op?(op_type)
    user = User.first_admin
    inventory = inventory_clazz.where(:bill_date => bill_date,:from_org_id => from_org_id,:to_org_id => to_org_or_yard_id).first
    if inventory.blank?
      inventory = inventory_clazz.new(:bill_date => bill_date,:from_org_id => from_org_id,:to_org_id => to_org_or_yard_id,:user => user,:note => "系统自动生成" )
    end
    #判断2种状态:draft及confirm
    #每个分理处及分公司生成一张盘货单
    #
    #处理OP_BRANCH_OUT
    #from_org_id 分理处或分公司
    #to_org_id 货场或或总部
    ll_wb_ids = []

    if is_to_yard_op?(op_type)
      ll_wb_op_branch_out_ids = LoadListWithBarcode.where(:op_type => OP_BRANCH_OUT,:bill_date => bill_date,:from_org_id => from_org_id,:to_org_id => to_org_or_yard_id ).pluck(:id)

      #货场确认入库
      ll_wb_op_yard_confirm_ids = LoadListWithBarcode.where(:op_type => OP_YARD_CONFIRM,:bill_date => bill_date,:from_org_id => from_org_id,:to_org_id => to_org_or_yard_id ).pluck(:id)

      #货场自行入库
      ll_wb_op_yard_in_ids = LoadListWithBarcode.where(:op_type => OP_YARD_IN,:bill_date => bill_date,:from_org_id => to_org_or_yard_id,:to_org_id => to_org_or_yard_id ).pluck(:id) 
      ll_wb_ids =ll_wb_op_branch_out_ids.to_a + ll_wb_op_yard_confirm_ids.to_a + ll_wb_op_yard_in_ids.to_a
    end

    if is_to_branch_op?(op_type)
      #货场出库
      ll_wb_op_yard_out_ids = LoadListWithBarcode.where(:op_type => OP_YARD_OUT,:bill_date => bill_date,:from_org_id => from_org_id,:to_org_id => to_org_or_yard_id ).pluck(:id)

      #分公司或分理处确认入库
      ll_wb_op_branch_confirm_ids = LoadListWithBarcode.where(:op_type => OP_BRANCH_CONFIRM,:bill_date => bill_date,:from_org_id => from_org_id,:to_org_id => to_org_or_yard_id ).pluck(:id)

      #分公司自行入库
      ll_wb_op_branch_in_ids = LoadListWithBarcode.where(:op_type => OP_BRANCH_IN,:bill_date => bill_date,:from_org_id => to_org_or_yard_id,:to_org_id => to_org_or_yard_id ).pluck(:id) 
      ll_wb_ids =ll_wb_op_yard_out_ids.to_a + ll_wb_op_branch_confirm_ids.to_a + ll_wb_op_branch_in_ids.to_a
    end

    #循环获取扫码数据,已确认的
    lines = LoadListWithBarcodeLine.select(" substring(barcode,4,12) as bill_no,state,count(1) as num")
      .where(:load_list_with_barcode_id => ll_wb_ids).group("substring(barcode,4,12),state")
    grouped_lines = lines.group_by {|l| l.bill_no}

    logger.debug(grouped_lines )

    #重新计算明细
    re_cal_lines = grouped_lines.collect do |k,v|
      load_num = v.find {|v_line| v_line.state.eql?('draft')}.try(:num)
      confirm_num = v.find {|v_line| v_line.state.eql?('confirmed')}.try(:num)
      exception_num = v.find {|v_line| v_line.state.eql?('goods_exception')}.try(:num)

      #装车数量为已装车数量 + 确认数量
      load_num = load_num.to_i + confirm_num.to_i

      ret = {
        :bill_no => k,
        :load_num => load_num.to_i,
        :confirm_num => confirm_num.to_i,
        :exception_num => exception_num.to_i
      }
      ret
    end

    logger.debug(re_cal_lines )

    re_cal_lines.each do |line|
      bill_no = line[:bill_no]
      carrying_bill = CarryingBill.select(:id).where(:bill_no => bill_no).first
      act_load_list_line = inventory.act_load_list_lines.where(:carrying_bill_id => carrying_bill.id).first
      vals = line.extract!(:load_num,:confirm_num,:exception_num)


      #NOTE 默认扫描15件,扫过15件,默认全部扫描
      vals[:load_num] = carrying_bill.goods_num if vals[:load_num] >= 15
      vals[:confirm_num] = carrying_bill.goods_num if vals[:confirm_num] >= 15
      #如果找到记录,则更新,否则新建
      if act_load_list_line.present?

        logger.debug(act_load_list_line)
        act_load_list_line.update_attributes(vals)
      else
        vals["carrying_bill_id"] = carrying_bill.id
        logger.debug(vals)
        inventory.act_load_list_lines.build(vals)
      end
    end
    inventory.save!
  end

  default_value_for :bill_date do
    Date.today
  end
  #定义状态机
  state_machine :initial => :draft do
    #到货确认后,设置确认时间
    after_transition do |l,transition|
      l.update_attributes(:confirm_date => Date.today)
    end
    event :confirm do
      transition :draft =>:confirmed
    end
  end

  #待确认单据,用于app调用
  scope :waitting_confirm,lambda {|to_org_id| where(:state => :draft,:to_org_id => to_org_id)}

  def self.get_confirms_for_app(to_org_id)
    bills = waitting_confirm(to_org_id)
    #op_type需要一些转换
    #branch_out -> yard_confirm
    #yard_out -> branch_confirm
    bills.each do |l|
      l['op_type'] = OP_YARD_CONFIRM if l['op_type'].eql?(OP_BRANCH_OUT)
      l['op_type'] = OP_BRANCH_CONFIRM if l['op_type'].eql?(OP_YARD_OUT)
    end
    bills
  end

  #override as_json
  #参考http://stackoverflow.com/questions/2572284/how-to-override-to-json-in-rails
  def as_json(options = {})
    super(:include => :load_list_with_barcode_lines)
  end
end
