# -*- encoding : utf-8 -*-
# carrying_bill的方法定义和class_methods定义
module CarryingBillExtend
  module CarryingBill
    def self.included(base)
      base.extend ClassMethods
    end
    #付款方式描述
    def pay_type_des
      pay_type_des = ""
      PayType.pay_types.each {|des,code| pay_type_des = des if code == self.pay_type }
      pay_type_des
    end
    def from_org_name
      self.from_org.name unless self.from_org.nil?
    end
    def transit_org_name
      try(:transit_org).try(:name)
    end

    def to_org_name
      self.to_org.name unless self.to_org.nil?
    end

    #显示父机构名称,如果父机构不存在,则显示当前机构名称
    def to_parent_org_name
      ret = to_org_name
      ret = to_org.parent.name if to_org.parent_id.present?
      ret
    end
    #发货人卡号
    def from_customer_bank_card
      return '' if self.from_customer.blank?
      self.from_customer.bank_card
    end
    #发货人编号
    def from_customer_code
      return '' if self.from_customer.blank?
      self.from_customer.code
    end
    #代收货款转账银行
    def from_customer_bank_name
      return '' if self.from_customer.blank?
      self.from_customer.bank.name
    end
    #提付运费,付款方式为提货付时,等于运费,其他为0
    def carrying_fee_th
      ret = 0
      ret = self.carrying_fee if self.pay_type == PayType::PAY_TYPE_TH
      ret
    end
    #提货保价费
    def insured_fee_th
      ret = 0
      ret = self.insured_fee if self.pay_type == PayType::PAY_TYPE_TH
      ret
    end
    #ADD at 2012-9-23
    #提货发货短途费,运费支付方式为提货付时,等于发货短途费,其他为0
    def from_short_carrying_fee_th
      ret = 0
      ret = self.from_short_carrying_fee if self.pay_type == PayType::PAY_TYPE_TH
      ret
    end
    #ADD at 2012-9-23
    #提货到货短途费,运费支付方式为提货付时,等于到货短途费,其他为0
    def to_short_carrying_fee_th
      ret = 0
      ret = self.to_short_carrying_fee if self.pay_type == PayType::PAY_TYPE_TH
      ret
    end


    #扣运费,运费支付方式为从货款扣除时等于运费,否则为0
    def k_carrying_fee
      ret = 0
      ret = self.carrying_fee if self.pay_type == PayType::PAY_TYPE_K_GOODSFEE
      ret
    end
    #2012-9-23
    #扣保险费,运费支付为[从货款扣]时等与保险费,否则为0
    def k_insured_fee
      ret = 0
      ret = self.insured_fee if self.pay_type == PayType::PAY_TYPE_K_GOODSFEE
      ret
    end
    #2012-9-23
    #扣发货短途,运费支付为[从货款扣]时等于发货短途费,否则为0
    def k_from_short_carrying_fee
      ret = 0
      ret = self.from_short_carrying_fee if self.pay_type == PayType::PAY_TYPE_K_GOODSFEE
      ret
    end
    #2012-9-23
    #扣到货短途,运费支付为[从货款扣]时等于到货短途费,否则为0
    def k_to_short_carrying_fee
      ret = 0
      ret = self.to_short_carrying_fee if self.pay_type == PayType::PAY_TYPE_K_GOODSFEE
      ret
    end
    #added 2013-10-14
    #提货应收管理费
    def manage_fee_th
      ret = 0
      ret = self.manage_fee if self.pay_type == PayType::PAY_TYPE_TH
      ret
    end
    #added 2013-10-14
    #扣管理费
    def k_manage_fee
      ret = 0
      ret = self.manage_fee if self.pay_type == PayType::PAY_TYPE_K_GOODSFEE
      ret
    end
    #Added at 2012-9-23
    #扣运费合计 = 扣运费 + 扣保险费 + 扣到货短途 + 扣发货短途
    def k_carrying_fee_total
      self.k_carrying_fee + self.k_from_short_carrying_fee + self.k_to_short_carrying_fee
    end

    #实提货款 原货款 - 扣运费 - 扣手续费
    #应付代收货款=代收货款减去千分之二手续费
    def act_pay_fee
      ret = goods_fee - k_hand_fee - transit_hand_fee
    end
    #代收运费解释：原票运费支付方式为提货付的，代收运费=原运费—中转运费；
    #原票运费支付方式为现金付的，代收运费为0
    def agent_carrying_fee
      ret = 0
      ret = self.carrying_fee_th - self.transit_carrying_fee if self.pay_type == PayType::PAY_TYPE_TH
      ret
    end

    #得到提货应收金额
    #NOTE 2012-09-23
    #运费支付方式为提货付时: 提货应收 = 提付运费 - 中转手续费 - 中转运费 + 货款 + 保险费 + 发货短途 + 收货短途
    #NOTE modify 2013-10-14 添加扣管理费项目
    #NOTE modify 2019-0-14
    #短途不计入分支机构应交账款：分理处不算现付接货短途、分公司不算提付送货短途
    #二维码结算客户:：应付代收货款=代收货款减去千分之二手续费。应收款=手续费+运费合计+保险费
    def th_amount
      amount = carrying_fee_th_total - transit_hand_fee - transit_carrying_fee_th + goods_fee + manage_fee_th + insured_fee_th
      #二维码结算客户需要单独算
      # amount = amount - goods_fee + k_hand_fee if is_qrcode_pay
      amount
    end

    #是否二维码结算客户
    def is_qrcode_pay
      from_customer.try(:is_qrcode_pay)
    end

    #发货人的收款二维码地址
    def from_customer_qrcode
      ret = ""
      if is_qrcode_pay
        ret = from_customer.try(:qr_photo_1).try(:url,:thumb) if from_customer.try(:qr_photo_1).present?
      end
      ret
    end
    #提付中转运费
    def transit_carrying_fee_th
      ret = 0
      ret = transit_carrying_fee if self.pay_type == PayType::PAY_TYPE_TH
      ret
    end

    #中转运费
    def transit_carrying_fee_th
      ret = 0
      ret = transit_carrying_fee if pay_type == PayType::PAY_TYPE_TH
      ret
    end

    #运费总计
    #NOTE  指的是运费 + 保险费 + 发货短途 + 到货短途,与付款方式无关
    #2012-9-23 发货短途运费和到货短途运费也计入合计运费中去
    #NOTE 运费合计 = 运费 + 保险费 + 发货地短途 + 到货地短途
    #2013-10-13 
    #NOTE 运费合计 = 运费 + 管理费 + 发货短途 + 到货短途

    def carrying_fee_total
      carrying_fee  + manage_fee + from_short_carrying_fee + to_short_carrying_fee
    end
    #提付运费合计
    #运费支付方式=提货付 提付运费合计 = 运费 + 保价费
    #其他支付方式 提副运费合计 = 0
    #2012-9-23 发货短途运费和到货短途运费也计入合计运费中去
    #付款方式为现金付时:提付运费合计 = 0
    #付款方式为提货付时:提付运费合计 = 运费 + 保险费 + 发货地短途 + 到货地短途
    #NOTE 2013-10-14 添加管理费项目
    def carrying_fee_th_total
      ret = 0
      ret = carrying_fee  + to_short_carrying_fee + from_short_carrying_fee if pay_type.eql?(PayType::PAY_TYPE_TH)
      # ret += k_hand_fee if is_qrcode_pay
      ret
    end

    #代收货款支付方式,无客户编号时,为现金支付
    def goods_fee_cash?
      self.from_customer.blank?
    end
    #是中转运单还是其他运单
    def transit_bill?
      ["TransitBill","HandTransitBill","OutterTransitReturnBill"].include? self.type
    end
    #滞留天数
    def stranded_days
      ((Date.today.end_of_day - self.bill_date.beginning_of_day) /1.day).to_i
    end
    #剩余未装车数量
    def rest_goods_num
      ret = goods_num
      ret = goods_num - self.act_load_list_lines.sum(:load_num) unless self.act_load_list_lines.blank?
      ret
    end

    #运费调整-增加
    def adjust_carrying_fee_plus
      adjust_carrying_fee >= 0.0 ? adjust_carrying_fee : 0.0
    end

    def is_urgent
      is_urgent = bill_association_object.try(:is_urgent?)
    end
    #加急描述
    def is_urgent_des
      ret =""
      ret = "急件" if bill_association_object.try(:is_urgent)
      ret
    end

    def is_receipt
      is_receipt = bill_association_object.try(:is_receipt?)
    end
    def is_outside
      is_outside = bill_association_object.try(:is_outside?)
    end


    #服务描述 加急或带回单
    def service_note
      is_urgent = bill_association_object.try(:is_urgent?)
      is_receipt = bill_association_object.try(:is_receipt?)
      service_notes = []
      service_notes.push("急")  if is_urgent
      service_notes.push("回单")  if is_receipt
      service_notes.join("|")
    end

    #运费调整-减少
    def adjust_carrying_fee_minus
      adjust_carrying_fee < 0.0 ? adjust_carrying_fee : 0.0
    end


    #定义customer_code虚拟属性
    def customer_code
      @customer_code || self.from_customer.try(:code)
    end
    def customer_code=(customer_code)
      @customer_code = customer_code
    end
    #转换为打印使用的json
    def to_print_json
      self.to_json(:except =>[:created_at,:updated_at],:methods => [:area,:from_org,:transit_org,:to_org,:user,:customer_code,:th_amount,
                                                                    :carrying_fee_total,:carrying_fee_th,:pay_type_des,:type,:created_at_str])
    end
    #录入时间str
    def created_at_str
      created_at.strftime("%Y-%m-%d %H:%M")
    end

    #发货地-到货地描述字符串
    def from_to_description
      des = from_org.name
      des += "至#{transit_org.name}" if transit_org.present?
      des += "至#{to_org.name}" if to_org.present?
      des += "转#{area.name}" if area.present?
      des
    end

    #根据货号计算排序号
    def sort_seq
      "#{self.bill_date.strftime('%y%m%d')}#{self.from_org.try(:simp_name)}#{self.transit_org.present? ? self.transit_org.try(:simp_name) : self.to_org.try(:simp_name)}"
    end
    #支付清单排序
    def payment_list_sort_seq
      "#{self.transit_org.present? ? self.transit_org.simp_name : self.to_org.simp_name}#{self.bill_date.strftime('%y%m%d')}#{self.from_org.simp_name}"
    end
    #票据费用是否修改
    def fee_changed?
      !original_goods_fee.eql?(goods_fee) or !original_carrying_fee.eql?(carrying_fee ) or !original_insured_amount.eql?(insured_amount) or !original_insured_fee.eql?(insured_fee) or !original_from_short_carrying_fee.eql?(from_short_carrying_fee)  or !original_to_short_carrying_fee.eql?(to_short_carrying_fee)
    end
    #是否已欠款提货
    def is_debt_bill
      completed? or DebtBillLine.exists?(:carrying_bill_id => id)
    end
    #到货区域
    def deliver_region
      ret = ""

      if to_imported_customer.present?
        ret = to_imported_customer.try(:address_desc_for_print)
      else
        ret = BranchCustomer.get_address_desc_for_print(to_org_id,to_customer_mobile)
      end
      ret
    end

    #票据状态,目前系统内部状态较多,根据客户要求修改为有限的几个状态
    def translate_state
      t_state = "已开票" if self.billed?
      t_state = "已发货" if self.loaded? or self.shipped? or self.reached? or self.distributed? or self.transited?
      t_state = "已提货" if self.deliveried? or self.settlemented?
      t_state = "已提货未提款" if self.refunded? or self.refunded_confirmed? or self.payment_listed?
      t_state = "已取款" if self.paid? or self.posted?
      t_state = "已退货" if self.returned?
      t_state = "已作废" if self.invalided?
      t_state
    end
    #是否已保存短途信息

    def from_short_fee_saved?
      short_fee_info_lines.joins(:short_fee_info).where("short_fee_infos.org_id = ?",from_org_id).exists?
    end
    def to_short_fee_saved?
      short_fee_info_lines.joins(:short_fee_info).where("short_fee_infos.org_id = ?",to_org_id).exists?
    end

    #机打运单编号从4000000开始
    #生成票据编号
    def generate_bill_no
      gen_bill_count = BillNo.gen_bill_no
      gen_bill_no = Date.today.strftime("%Y%m%d") + format("%04d",gen_bill_count)
      self.bill_no = gen_bill_no
    end
    def generate_goods_no
      #货号规则
      #6位年月日+始发地市+到达地市+始发组织机构代码（如返程货则为到达地组织机构代码）+序列号+“-”+件数
      #新建单据/修改发货地/到货地/中转地 重新生成货号
      if self.new_record?  or (self.changes[:goods_num].present? or self.changes[:from_org_id].present? or self.changes[:to_org_id].present? or self.changes[:transit_org_id].present?)
        # self.goods_no = GoodsNo.gen_goods_no(self)
        self.goods_no = self.bill_no[8..11] + "-" + self.goods_num.to_s
      end
    end
    #生成退货单据
    #录入原运单编号后回车，可显示原票信息退货信息：
    #退货运单编号为TH原运单编号，
    #货号在确认时由电脑按始发货规则自动编，
    #结算单位、组织机构默认为当前操作员所属，
    #发货站、到达站、发货人、收货人、电话、手机为原票信息颠倒，
    #运费支付方式默认提货付，
    #代收货款默认为0，代收货款支付方式默认为现金支付，
    #货物信息、保价内容按原票显示，
    #运费如原票支付方式为现金付的则自动显示为单倍，其他支付方式的显示为双倍运费，
    #备注自动显示原票代收货款及货号。
    #如中转货退回，则中转站还显示原中转站。
    #确认后，原票状态应显示为已退且在未提货中取消，在本地发货时增加该票

    def generate_return_bill
      override_attr = {
        "bill_no" => "TH#{self.bill_no}",
        "bill_date"=> Date.today,
        "from_org_id"=> self.to_org_id,
        "transit_org_id"=> self.transit_org_id,
        "to_org_id"=> self.from_org_id,
        "from_customer_name"=> self.to_customer_name,
        "from_customer_phone"=> self.to_customer_phone,
        "from_customer_mobile"=> self.to_customer_mobile,
        "to_customer_name"=> self.from_customer_name,
        "to_customer_phone"=> self.from_customer_phone,
        "to_customer_mobile"=> self.from_customer_mobile,
        "from_customer_id"=> nil,
        "to_customer_id"=> nil,
        "pay_type"=> PayType::PAY_TYPE_TH,
        "goods_fee"=> 0,
        "manage_fee"=> self.manage_fee.to_i,
        "insured_fee" => (pay_type == PayType::PAY_TYPE_CASH ? self.insured_fee.to_i : self.insured_fee.to_i*2),
        "from_short_carrying_fee" => (pay_type == PayType::PAY_TYPE_CASH ? self.to_short_carrying_fee.to_i : self.to_short_carrying_fee.to_i*2),
        "to_short_carrying_fee" => (pay_type == PayType::PAY_TYPE_CASH ? self.from_short_carrying_fee.to_i : self.from_short_carrying_fee.to_i*2),
        "carrying_fee_1st" => (pay_type == PayType::PAY_TYPE_CASH ? self.carrying_fee_2st.to_i : self.carrying_fee_2st.to_i*2),
        "carrying_fee_2st" => (pay_type == PayType::PAY_TYPE_CASH ? self.carrying_fee_1st.to_i : self.carrying_fee_1st.to_i*2),
        "carrying_fee"=> (pay_type == PayType::PAY_TYPE_CASH ? self.carrying_fee.to_i : 2*self.carrying_fee.to_i),
        "note"=> "原运单票据号:#{self.bill_no},货号:#{self.goods_no},运费:#{self.carrying_fee},代收货款;#{self.goods_fee}"
      }
      #如果是外部中转票据,则将中转站与始发站调换
      override_attr.merge!("from_org_id"=> self.transit_org_id,"to_org_id"=> self.from_org_id) if self.area_id.present?
      return_attr = self.attributes.merge(override_attr)
      delete_attrs = %w[goods_no original_carrying_fee original_goods_fee original_from_short_carrying_fee insured_rate original_insured_amount type original_insured_fee id original_to_short_carrying_fee original_carrying_fee]
      return_attr.delete_if { |key,value| delete_attrs.include?(key)}
      self.build_return_bill(return_attr)
    end

    #卸车信息
    def scan_line_team
      return nil if scan_lines.blank?
      ret = nil
      ret = scan_lines.select {|v| v.scan_header.type.eql?("ScanHeaderTeam")}.try(:first)
      ret
    end

    #装卸入库-货场扫码信息
    def scan_line_load_in
      return nil if scan_lines.blank?
      ret = nil
      load_in_types = %w(ScanHeaderLoadIn ScanHeaderInnerTransitLoadIn ScanHeaderLocalTownLoadIn)
      ret = scan_lines.select {|v| load_in_types.include?(v.scan_header.type)}.try(:first)
      ret
    end

    #装卸出库-货场扫码信息
    def scan_line_load_out
      return nil if scan_lines.blank?
      ret = nil

      load_out_types = %w(ScanHeaderLoadOut ScanHeaderInnerTransitLoadOut ScanHeaderLocalTownLoadOut)
      ret = scan_lines.select {|v| load_out_types.include?(v.scan_header.type)}.try(:first)
      ret
    end

    #装卸组-扫码入库货物状态
    def goods_status_type_load_in
      ret = try(:scan_line_load_in).try(:goods_status_type)
      ret = 1 if ret.blank?
      ret
    end
    def goods_status_note_load_in
      try(:scan_line_load_in).try(:goods_status_note)
    end


    #装卸组-扫码出库货物状态
    def goods_status_type_load_out
      ret = try(:scan_line_load_out).try(:goods_status_type)
      ret = 1 if ret.blank?
      ret
    end

    def goods_status_note_load_out
      try(:scan_line_load_out).try(:goods_status_note)
    end

    #外部中转-到货地名称
    def area_name
      try(:area).try(:name)
    end


    #override as_json
    def to_json_for_app(options = nil)
      ex_options = {
        :only => [],
        :methods => [
          :id,:bill_date,:type,:bill_no,:goods_no,:goods_weight,:goods_volume,:package,:created_at_str,:from_customer_id,:from_customer_code,:from_customer_name,:from_customer_phone,:from_customer_mobile,
          :to_customer_name,:to_customer_phone,:to_customer_mobile,:from_org_id,:from_org_name,:area_name,
          :transit_org_name,:to_org_id,:to_org_name,:pay_type,:pay_type_des,:from_short_carrying_fee,:to_short_carrying_fee,
          :carrying_fee,:carrying_fee_th,:k_carrying_fee,:k_hand_fee,:goods_fee,:insured_fee,:manage_fee,:transit_carrying_fee,
          :transit_hand_fee,:act_pay_fee,:agent_carrying_fee,:th_amount,:goods_num,:goods_info,:service_note,:is_urgent,:is_receipt,:is_outside,:bank_name,:card_no,
          :note,:state,:human_state_name,:goods_status_type_load_in,:goods_status_note_load_in,:goods_status_type_load_out,:goods_status_note_load_out
        ]
      }

      if options.blank?
        to_json(ex_options)
      else
        to_json(options.merge!(ex_options))
      end
    end

    #修改to_json，包含methods
    def serializable_hash(options={})
      options = {
        :methods => [
          :id,:bill_date,:type,:bill_no,:goods_no,:from_customer_id,:from_customer_code,:from_customer_name,:from_customer_phone,:from_customer_mobile,
          :to_customer_name,:to_customer_phone,:to_customer_mobile,:from_org_id,:from_org_name,
          :transit_org_name,:to_org_id,:to_org_name,:pay_type,:pay_type_des,:from_short_carrying_fee,:to_short_carrying_fee,
          :carrying_fee,:carrying_fee_total,:carrying_fee_th,:k_carrying_fee,:k_hand_fee,:goods_fee,:insured_fee,:manage_fee,:transit_carrying_fee,
          :transit_hand_fee,:act_pay_fee,:agent_carrying_fee,:th_amount,:goods_num,:goods_info,
          :note,:state,:human_state_name,:goods_status_type_load_in,:goods_status_note_load_in,:goods_status_type_load_out,:goods_status_note_load_out
        ]
      }.update(options)
      super(options)
    end


    #运单跟踪信息
    def track_info
      ret =[]
      #开单
      ret << {:op_date => created_at.strftime("%Y-%m-%d %H:%M:%S"),
              :op_type => "#{created_at.strftime("%Y-%m-%d %H:%M:%S")}开票",
              :username => user.try(:real_name)}
      #卸车
      ret << {:op_date => scan_line_team.created_at.strftime("%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{scan_line_team.created_at.strftime("%Y-%m-%d %H:%M:%S")}卸车",
              :username => scan_line_team.try(:scan_header).try(:user).try(:real_name)} if scan_line_team.present?
     
      #货场入库
      ret << {:op_date => scan_line_load_in.created_at.strftime("%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{scan_line_load_in.created_at.strftime("%Y-%m-%d %H:%M:%S")}进行装卸组入库操作",
              :username => scan_line_load_in.try(:scan_header).try(:user).try(:real_name)} if scan_line_load_in.present?
      #装卸组装车
      ret << {:op_date => scan_line_load_out.created_at.strftime("%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{scan_line_load_out.created_at.strftime("%Y-%m-%d %H:%M:%S")}进行装车操作",
              :username => scan_line_load_out.try(:scan_header).try(:user).try(:real_name)} if scan_line_load_out.present?

      #发车
      ret << {:op_date => load_list.created_at.strftime("%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{load_list.created_at.strftime("%Y-%m-%d %H:%M:%S")}进行了发车操作",
              :username => load_list.try(:user).try(:real_name)} if load_list.present?
      #中转到货
      ret << {:op_date => load_list.try(:transit_reached_datetime).try(:strftime,"%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{load_list.try(:transit_reached_datetime).try(:strftime,"%Y-%m-%d %H:%M:%S")}中转部到货确认操作",
              :username => load_list.try(:transit_reached_user).try(:real_name)} if load_list.present? and load_list.transit_reached_user.present?

      #中转发车
      ret << {:op_date => load_list.try(:transit_ship_datetime).try(:strftime,"%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{load_list.try(:transit_ship_datetime).try(:strftime,"%Y-%m-%d %H:%M:%S")}中转部发车操作",
              :username => load_list.try(:transit_ship_user).try(:real_name)} if load_list.present? and load_list.transit_ship_user.present?


      #到货
      ret << {:op_date => load_list.reached_datetime.try(:strftime,"%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{load_list.reached_datetime.try(:strftime,"%Y-%m-%d %H:%M:%S")}到达#{load_list.try(:to_org).try(:name)}",
              :username => load_list.reached_user } if load_list.present? and load_list.reached?
      #提货
      ret << {:op_date => deliver_info.created_at.strftime("%Y-%m-%d %H:%M:%S"),
              :op_type => "#{deliver_info.try(:customer_name)}在#{deliver_info.created_at.strftime("%Y-%m-%d %H:%M:%S")}提货",
              :username => deliver_info.try(:user).try(:real_name)} if deliver_info.present? and deliver_info.deliveried?
      #日结
      ret << {:op_date => settlement.created_at.strftime("%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{settlement.created_at.strftime("%Y-%m-%d %H:%M:%S")}进行了日结操作",
              :username => settlement.try(:user).try(:real_name)} if settlement.present? and settlement.settlemented?
      #返款
      ret << {:op_date => refound.created_at.strftime("%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{refound.created_at.strftime("%Y-%m-%d %H:%M:%S")}进行了返款操作",
              :username => refound.try(:user).try(:real_name)} if refound.present? and (refound.refunded_confirmed? or refound.refunded?)
      #返款已确认
      ret << {:op_date => refound.updated_at.strftime("%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{refound.updated_at.strftime("%Y-%m-%d %H:%M:%S")}进行了返款确认操作",
              :username => ""} if refound.present? and refound.refunded_confirmed?

      #等待支付货款
      ret << {:op_date => payment_list.created_at.strftime("%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{payment_list.created_at.strftime("%Y-%m-%d %H:%M:%S")}生成了支付清单",
              :username => payment_list.try(:user).try(:real_name)} if payment_list.present? and payment_list.payment_listed?
      #货款已支付
      ret << {:op_date => pay_info.created_at.strftime("%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{pay_info.created_at.strftime("%Y-%m-%d %H:%M:%S")},已向#{pay_info.try(:customer_name)}支付了货款",
              :username => pay_info.try(:user).try(:real_name)} if pay_info.present? and pay_info.paid?
      #已结账
      ret << {:op_date => post_info.try(:created_at).try(:strftime,"%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{post_info.created_at.strftime("%Y-%m-%d %H:%M:%S")},进行了结账操作",
              :username => post_info.try(:user).try(:real_name)} if post_info.present? and post_info.posted?
      #理赔
      ret << {:op_date => goods_exception.try(:created_at).try(:strftime,"%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{goods_exception.created_at.strftime("%Y-%m-%d %H:%M:%S")},上报了理赔信息",
              :username => goods_exception.try(:user).try(:real_name)} if goods_exception.present?
      #货款调整
      if adjust_goods_fee_infos.present?
        adjust_goods_fee_infos.each do |adfi|
          adjust_des = ""
          if adfi.origin_goods_fee != adfi.adjust_goods_fee
            adjust_des = "货款自¥#{adfi.origin_goods_fee }变更为¥#{adfi.adjust_goods_fee},审批状态:#{adfi.human_state_name}"
          else
            adjust_des = "变更运单信息:#{adfi.other_adjust_note},审批状态:#{adfi.human_state_name}"
          end
          ret << {:op_date => adfi.try(:created_at).try(:strftime,"%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{adfi.created_at.strftime("%Y-%m-%d %H:%M:%S")},#{adjust_des}",
              :username => adfi.try(:user).try(:real_name)}
        end
      end
      #原货退回
      ret << {:op_date => return_bill.try(:created_at).try(:strftime,"%Y-%m-%d %H:%M:%S"),
              :op_type => "在#{return_bill.created_at.strftime("%Y-%m-%d %H:%M:%S")},做原货退回操作",
              :username => return_bill.try(:user).try(:real_name)} if return_bill.present?

      ret
    end

    #运单变更审计
    def audit_infos
      ret = []
      audits.each_with_index do |aud,idx|
        if aud.audited_changes.has_key?("carrying_fee")
          carrying_fee_from = aud.audited_changes['carrying_fee'].first
          carrying_fee_to = aud.audited_changes['carrying_fee'].second
          op_date = aud.try(:created_at).try(:strftime,"%Y-%m-%d %H:%M:%S")
          ret << {:op_date => op_date,
                  :op_type => "#{op_date},运费变更:#{carrying_fee_from}至#{carrying_fee_to}",
                  :username => aud.try(:user).try(:real_name)}
        end

        if aud.audited_changes.has_key?("goods_fee")
          op_date = aud.try(:created_at).try(:strftime,"%Y-%m-%d %H:%M:%S")
          goods_fee_from = aud.audited_changes['goods_fee'].first
          goods_fee_to = aud.audited_changes['goods_fee'].second
          ret << {:op_date => op_date,
                  :op_type => "#{op_date},货款变更:#{goods_fee_from}至#{goods_fee_to}",
                  :username => aud.try(:user).try(:real_name)}
        end

        if aud.audited_changes.try(:include?,'goods_info') and aud.new_attributes['goods_info'].try(:end_with?,'#cancel')
          op_date = aud.try(:created_at).try(:strftime,"%Y-%m-%d %H:%M:%S")
          ret << {:op_date => op_date,
                  :op_type => "运单注销",
                  :username => aud.try(:user).try(:real_name)}

        end

        if aud.audited_changes.try(:include?,'goods_info') and aud.new_attributes['goods_info'].try(:end_with?,'#reset')
          op_date = aud.try(:created_at).try(:strftime,"%Y-%m-%d %H:%M:%S")
          ret << {:op_date => op_date,
                  :op_type => "运单重置",
                  :username => aud.try(:user).try(:real_name)}


        end
        # if aud.audited_changes.try(:include?,'goods_info') and aud.new_attributes['goods_info'].try(:end_with?,'#return')
        #   op_date = aud.try(:created_at).try(:strftime,"%Y-%m-%d %H:%M:%S")
        #   ret << {:op_date => op_date,
        #           :op_type => "退货操作",
        #           :username => aud.try(:user).try(:real_name)}
        #
        # end
      end
      ret
    end
    #带回单描述
    def is_receipt_des
      ret =""
      ret = "带回单" if bill_association_object.try(:is_receipt)
      ret
    end

    #重写to_s方法
    def to_s
      "#{self.bill_no}/#{self.goods_no}"
    end

    module ClassMethods
      #导出短信文本
      def export_sms_txt_for_arrive(ids=[])
        #去除固定电话和空号
        sms_bills = self.find(ids).find_all {|bill| bill.sms_mobile_for_arrive.present? }
        no_mobile_sms_bills = self.find(ids).find_all {|bill| bill.sms_mobile_for_arrive.blank? }
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
          sms_text += Settings.notice_arrive.sms_batch % [key,bills[0].to_org.try(:name),goods_nos.join(" "),goods_fee,bills[0].to_org.try(:location),bills[0].to_org.try(:phone)]
        end
        sms_text +="===============================以下运单无手机号===============================================\r\n"
        no_mobile_sms_bills.each do |bill|
          goods_no = bill.goods_no[6..-1]
          sms_text += Settings.notice_arrive.sms_batch % [bill.try(:phone_or_mobile_for_arrive),bill.to_org.try(:name),goods_no,bill.th_amount,bill.to_org.try(:location),bill.to_org.try(:phone)]
        end
        sms_text
      end
      #为提货未提款票据导出短信
      def export_sms_txt_for_rpt_no_pay(ids=[])
        #去除固定电话
        selected_bills = where(:id => ids)
        sms_bills = selected_bills.find_all {|bill| bill.sms_mobile_for_sender.present? and bill.goods_fee > 0 }
        no_mobile_sms_bills = selected_bills.find_all {|bill| bill.sms_mobile_for_sender.blank? and bill.goods_fee > 0 }
        group_sms_bills = sms_bills.group_by(&:sms_mobile_for_sender)
        #分别合计货物件数/运费合计/货款合计
        sms_text = ''
        group_sms_bills.each do |key,bills|
          goods_num = bills.to_a.sum(&:goods_num)
          carrying_fee_th = 0.0
          bill_nos = []
          bills.each do |the_bill|
            carrying_fee_th += the_bill.carrying_fee if the_bill.pay_type.eql?(PayType::PAY_TYPE_TH)
            bill_nos << the_bill.bill_no
          end
          #goods_fee = bills.to_a.sum(&:goods_fee).try(:to_i)
          sms_text += Settings.notice_cash_payment_list.sms_batch % [key,bill_nos.join(" ")]
        end
        #加一个空行
        sms_text +="===============================以下运单无手机号===============================================\r\n"
        no_mobile_sms_bills.each do |bill|
          sms_text += Settings.notice_cash_payment_list.sms_batch % [bill.try(:phone_or_mobile_for_sender),bill.bill_no]
        end
        sms_text
      end

      #导出方法
      def to_csv(search_obj,options = {},with_bom_header = true)
        options = self.export_options if options.blank?
        sum_info = self.search_sum(search_obj)
        #导出明细信息
        ret = search_obj.where('1=1').with_association.export_csv(options,with_bom_header)
        #导出合计信息
        sum_array =["合计:#{sum_info[:count]}票"]
        options[:methods].each do |method_name|
          sum_value = sum_info["sum_#{method_name}".to_sym]
          if sum_value.present? and sum_value.is_a?(Numeric)
            sum_array << sum_value
          else
            sum_array << ""
          end
        end
        ret = ret + sum_array.export_line_csv
        ret
      end

      #得到二维码支付的货款及手续费合计
      def search_sum_for_qr_pay(search)
        customer_ids = search.where("1=1").pluck("carrying_bills.from_customer_id").compact
        customer_ids.uniq!
        #筛选出二维码支付客户
        qr_customer_ids = Vip.where(:id => customer_ids,:is_qrcode_pay => true).pluck(:id)
        #获取合计数据
        sum_info = {
          #现金付运费合计
          :sum_carrying_fee_cash_qr_pay => search.where(:pay_type => PayType::PAY_TYPE_CASH,:from_customer_id => qr_customer_ids).sum(:carrying_fee),
          #提货付运费合计
          :sum_carrying_fee_th_qr_pay => search.where(:pay_type => PayType::PAY_TYPE_TH,:from_customer_id => qr_customer_ids).sum(:carrying_fee),
          #货款合计
          :sum_goods_fee_qr_pay => search.where(:from_customer_id => qr_customer_ids).sum(:goods_fee),
          #扣手续费
          :sum_k_hand_fee_qr_pay => search.where(:from_customer_id => qr_customer_ids).sum(:k_hand_fee),
        }
        sum_info
      end
      #得到票据合计信息
      def search_sum(search)
        sum_info = {
          #现金付运费合计
          :sum_carrying_fee_cash => search.where(:pay_type => PayType::PAY_TYPE_CASH).sum(:carrying_fee),
          #提货付运费合计
          :sum_carrying_fee_th => search.where(:pay_type => PayType::PAY_TYPE_TH).sum(:carrying_fee),
          #回执付运费合计
          :sum_carrying_fee_re => search.where(:pay_type => PayType::PAY_TYPE_RETURN).sum(:carrying_fee),
          #自货款扣除运费合计
          :sum_k_carrying_fee => search.where(:pay_type => PayType::PAY_TYPE_K_GOODSFEE).sum(:carrying_fee),
          #自货款扣保险费
          :sum_k_insured_fee => search.where(:pay_type => PayType::PAY_TYPE_K_GOODSFEE).sum(:insured_fee),
          #自货款扣发货短途
          :sum_k_from_short_carrying_fee => search.where(:pay_type => PayType::PAY_TYPE_K_GOODSFEE).sum(:from_short_carrying_fee),
          #自货款扣到货短途
          :sum_k_to_short_carrying_fee => search.where(:pay_type => PayType::PAY_TYPE_K_GOODSFEE).sum(:to_short_carrying_fee),
          #NOTE 2013-10-14 扣管理费
          :sum_k_manage_fee => search.where(:pay_type => PayType::PAY_TYPE_K_GOODSFEE).sum(:manage_fee),
          #提付保价费合计
          :sum_insured_fee_th => search.where(:pay_type => PayType::PAY_TYPE_TH).sum(:insured_fee),
          #2012-9-23 付款方式为提货付时,合计发货短途运费及到货短途运费
          :sum_from_short_carrying_fee_th => search.where(:pay_type => PayType::PAY_TYPE_TH).sum(:from_short_carrying_fee),
          :sum_to_short_carrying_fee_th => search.where(:pay_type => PayType::PAY_TYPE_TH).sum(:to_short_carrying_fee),
          #NOTE 2013-10-14 提付管理费
          :sum_manage_fee_th => search.where(:pay_type => PayType::PAY_TYPE_TH).sum(:manage_fee),
          #提付中转运费合计
          :sum_transit_carrying_fee_th => search.where(:pay_type => PayType::PAY_TYPE_TH).sum(:transit_carrying_fee),
          #运费调整-增加合计
          :sum_adjust_carrying_fee_plus => search.where(["adjust_carrying_fee >= 0.0"]).sum(:adjust_carrying_fee),
          #运费调整-减少合计
          :sum_adjust_carrying_fee_minus => search.where(["adjust_carrying_fee < 0.0"]).sum(:adjust_carrying_fee)

        }
        #FIXME 此处应使用 left join
        sum_info_tmp = search.joins("LEFT JOIN bill_association_objects bao ON carrying_bills.id = bao.customerable_id").select('sum(1) as sum_count,sum(carrying_fee) as sum_carrying_fee,
                                     sum(k_hand_fee) as sum_k_hand_fee,sum(goods_fee) as sum_goods_fee,
                                     sum(insured_fee) as sum_insured_fee,
                                     sum(manage_fee) as sum_manage_fee,
                                     sum(transit_carrying_fee) as sum_transit_carrying_fee,
                                     sum(transit_hand_fee) as sum_transit_hand_fee,
                                     sum(from_short_carrying_fee) as sum_from_short_carrying_fee,
                                     sum(to_short_carrying_fee) as sum_to_short_carrying_fee,
                                     sum(carrying_fee_1st) as sum_carrying_fee_1st,
                                     sum(carrying_fee_2st) as sum_carrying_fee_2st,
                                     sum(goods_num) as sum_goods_num,
                                     sum(goods_weight) as sum_goods_weight,
                                     sum(goods_volume) as sum_goods_volume,
                                     sum(bao.from_org_divide_fee) as sum_from_org_divide_fee,
                                     sum(bao.transit_org_divide_fee) as sum_transit_org_divide_fee,
                                     sum(bao.to_org_divide_fee) as sum_to_org_divide_fee,
                                     sum(bao.summary_org_divide_fee) as sum_summary_org_divide_fee').first.attributes

        #NOTE 当sql语句中有group by时,sum返回的是OrderedHash,此时需要转换
        sum_info.each do |k,v|
          if v.is_a? Hash
            sum_info[k] = v.values.inject(0){|sum,x| sum+x }
          end
        end

        #将hash key转换为symbol
        sum_info.merge!(Hash[sum_info_tmp.map{ |k, v| [k.to_sym, (v.blank? ? 0 : v)] }])
        #运费合计 运费+保险费+发货短途 + 到货短途
        sum_info[:sum_carrying_fee_total] = sum_info[:sum_carrying_fee] +  sum_info[:sum_from_short_carrying_fee] + sum_info[:sum_to_short_carrying_fee] + sum_info[:sum_manage_fee]
        #从货款扣运费合计
        sum_info[:sum_k_carrying_fee_total] = sum_info[:sum_k_carrying_fee] +  sum_info[:sum_k_from_short_carrying_fee] + sum_info[:sum_k_to_short_carrying_fee]

        #实提货款合计
        sum_info[:sum_act_pay_fee] = sum_info[:sum_goods_fee] - sum_info[:sum_k_hand_fee] - sum_info[:sum_transit_hand_fee] - sum_info[:sum_k_carrying_fee_total] - sum_info[:sum_k_insured_fee]
        sum_info[:sum_agent_carrying_fee] =0
        #提付运费大于零时,才有代收运费,否则代收运费为0
        sum_info[:sum_agent_carrying_fee] = sum_info[:sum_carrying_fee_th] - sum_info[:sum_transit_carrying_fee] if sum_info[:sum_carrying_fee_th] > 0
        #提付运费合计
        sum_info[:sum_carrying_fee_th_total] = sum_info[:sum_carrying_fee_th] + sum_info[:sum_from_short_carrying_fee_th] + sum_info[:sum_to_short_carrying_fee_th] + sum_info[:sum_manage_fee_th]
        #提货应收合计
        sum_info[:sum_th_amount] = sum_info[:sum_carrying_fee_th_total] + sum_info[:sum_insured_fee_th] - sum_info[:sum_transit_carrying_fee_th] -  sum_info[:sum_transit_hand_fee] + sum_info[:sum_goods_fee]

        #二维码结算客户:：应付代收货款=代收货款减去千分之二手续费。应收款=手续费+运费合计+保险费
        sum_info_qr_pay = search_sum_for_qr_pay(search)
        sum_info[:sum_goods_fee] = sum_info[:sum_goods_fee] - sum_info_qr_pay[:sum_goods_fee_qr_pay]
        sum_info[:sum_th_amount] = sum_info[:sum_th_amount] - sum_info_qr_pay[:sum_goods_fee_qr_pay] + sum_info_qr_pay[:sum_k_hand_fee_qr_pay]
        sum_info
      end

      protected
      #导出选项
      def export_options
        {
          :only => [],
          :methods => [
            :bill_date,:bill_no,:goods_no,:from_customer_name,:from_customer_phone,:from_customer_mobile,
            :to_customer_name,:to_customer_phone,:to_customer_mobile,:from_org_name,
            :transit_org_name,:to_org_name,:pay_type_des,:from_short_carrying_fee,:to_short_carrying_fee,
            :carrying_fee,:carrying_fee_th,:k_carrying_fee,:k_hand_fee,:goods_fee,:insured_fee,:manage_fee,:transit_carrying_fee,
            :transit_hand_fee,:act_pay_fee,:agent_carrying_fee,:th_amount,:goods_num,:note,:human_state_name
          ],
          :include => [:from_customer,:from_org,:to_org]
        }
      end
    end

  end
end
