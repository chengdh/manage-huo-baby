# -*- encoding : utf-8 -*-
#运单凭证生成相关定义
module CarryingBillExtend
  module AccountingDocument
    def self.included(base)
      base.extend(ClassMethods)
    end
    module ClassMethods
      #生成始发货现付凭证
      #贷方： 现金            --
      #借方： 营业收入     (见附表)
      #       其他收入      (保险费)
      #@params_search hash 查询条件
      #@context 其他附加的参数
      # context[:org_name]分理处,分公司名称
      # context[:note_date]摘要日期
      #@return accounting_lines array 凭证分录数组
      #        detail_lines array 附录明细 
      def build_accounting_document_from_cash(params_search={},context={})
        context[:note_date] ||= Date.today.strftime("%Y-%m-%d")
        context[:note_date] = context[:note_date][5..9]
        context[:org_name] = '郑' if not context[:org_name]
        params_search[:pay_type_eq] = "CA"
        carrying_fee = self.search(params_search).sum("carrying_fee + from_short_carrying_fee + to_short_carrying_fee").to_i
        insured_fee = self.search(params_search).sum(:insured_fee).to_i
        #借方
        dr_lines = []
        dr =  carrying_fee + insured_fee
        dr_line = {
          :description => "#{context[:note_date]}#{context[:org_name]}收",
          #总账科目
          :gen_led =>  '现金',
          #明细科目
          :sub_led =>  '-',
          :dr => dr,
          :dr_str => dr.to_s
        }
        dr_lines.append(dr_line)
        #贷方
        cr_lines = []
        #运费
        cr_line_1 =  {
          :description => "",
          #总账科目
          :gen_led =>  '营业收入',
          #明细科目
          :sub_led =>  '见附表',
          :cr => carrying_fee,
          :cr_str => carrying_fee.to_s
        }
        cr_lines.append(cr_line_1)
        #保险费
        cr_line_2 =  {
          :description => "",
          #总账科目
          :gen_led => '其他收入',
          #明细科目
          :sub_led =>  '保险费',
          :cr => insured_fee,
          :cr_str => insured_fee.to_s
        }
        cr_lines.append(cr_line_2)
        #计算分组明细
        cr_detail_lines,dr_detail_lines = self.build_detail_from_cash(params_search)
        #返回 贷方 借方 明细 上下文变量
        return cr_lines,dr_lines,cr_detail_lines,dr_detail_lines,context
      end

      #生成始发地现付明细
      #分别按照到货地进行分组合计
      def build_detail_from_cash(params_search={},context = {})
        cr_detail_lines = []
        params_search[:pay_type_eq] = "CA"
        bills = self.group_by_to_org_id_and_from_org_id.search(params_search)
        group_bills = bills.group_by(&:to_org)
        group_bills.each do |to_org,bills|
          lines = []
          bills.sort_by {|b| b.from_org.try(:order_by)}.each_with_index do |b,index|
            fee =(b.carrying_fee + b.from_short_carrying_fee + b.to_short_carrying_fee).to_i
            lines.append({
              :from_org => b.from_org,
              :item1 => "#{b.to_org.simp_name}",
              :item2 => "#{b.from_org.simp_name}",
              :fee => fee,
              :fee_str => fee.to_s
            })
            #lines[0][:item1] =  "#{b.to_org.simp_name}" if index == 0
          end
          cr_detail_lines += lines
        end
        #排序
        lines = cr_detail_lines.sort_by {|l| l[:from_org].try(:order_by)}
        return lines,[]
      end

      #生成始发货提付凭证
      #@params_search hash 查询条件
      def build_accounting_document_from_th(params_search={},context={})
        context[:note_date] ||= Date.today.strftime("%Y-%m-%d")
        context[:org_name] = '郑' if not context[:org_name]
        context[:note_date] = context[:note_date][5..9]

        goods_fee = self.search(params_search).sum(:goods_fee).to_i

        #NOTE 运费和保险费需要只提取付款方式是TH的记录
        #20151001 由于分公司不再返到货短途,生成凭证时也去除到货短途
        params_search[:pay_type_eq] = "TH"
        carrying_fee = self.search(params_search).sum("carrying_fee + from_short_carrying_fee").to_i
        insured_fee = self.search(params_search).sum(:insured_fee).to_i

        #借方
        dr_lines = []
        dr =  carrying_fee + goods_fee + insured_fee 
        dr_line = {
          :description => "收#{context[:org_name]}#{context[:note_date]}返款",
          #总账科目
          :gen_led =>  '应收账款',
          #明细科目
          :sub_led =>  context[:org_name],
          :dr => dr,
          :dr_str => dr.to_s
        }
        dr_lines.append(dr_line)
        #贷方
        cr_lines = []
        #货款
        cr_line_1 =  {
          :description => "",
          #总账科目
          :gen_led =>  '应付帐款',
          #明细科目
          :sub_led =>  "",
          :cr => goods_fee,
          :cr_str => goods_fee.to_s
        }
        cr_lines.append(cr_line_1)
        #运费
        cr_line_2 =  {
          :description => "",
          #总账科目
          :gen_led => '营业收入',
          #明细科目
          :sub_led =>  '运费见附表',
          :cr => carrying_fee,
          :cr_str => carrying_fee.to_s
        }
        cr_lines.append(cr_line_2)
        #保险费
        cr_line_3 =  {
          :description => "",
          #总账科目
          :gen_led => '其他收入',
          #明细科目
          :sub_led =>  '保险费',
          :cr => insured_fee,
          :cr_str => insured_fee.to_s
        }
        cr_lines.append(cr_line_3) if insured_fee > 0

        #计算分组明细
        cr_detail_lines,dr_detail_lines = self.build_detail_from_th(params_search)
        return cr_lines,dr_lines,cr_detail_lines,dr_detail_lines,context
      end

      #生成始发货提付凭证明细
      def build_detail_from_th(params_search)
        cr_detail_lines = []
        bills = self.group_by_to_org_id_and_from_org_id.search(params_search)
        bills.all.sort_by {|b| b.from_org.try(:order_by)}.each do |b|
          #20151001 由于分公司不再返到货短途,生成凭证时也去除到货短途
          fee = (b.carrying_fee + b.from_short_carrying_fee).to_i
          cr_detail_lines.append({
            :item1 => "#{b.from_org.simp_name}",
            :item2 => "",
            :fee => fee,
            :fee_str => fee.to_s
          })
        end
        return cr_detail_lines,[]
      end

      #生成返程货现付凭证
      #@params_search hash 查询条件
      def build_accounting_document_to_cash(params_search={},context={})
        params_search[:pay_type_eq] = "CA"
        context[:note_date] ||= Date.today.strftime("%Y-%m-%d")
        context[:note_date] = context[:note_date][5..9]
 
        context[:org_name] = '郑' if not context[:org_name]
        carrying_fee = self.search(params_search).sum("carrying_fee + from_short_carrying_fee + to_short_carrying_fee").to_i
        insured_fee = self.search(params_search).sum(:insured_fee).to_i
        #借方
        dr_lines = []
        dr =  carrying_fee + insured_fee
        dr_line = {
          :description => "#{context[:note_date]}返程现付",
          #总账科目
          :gen_led =>  '现金',
          #明细科目
          :sub_led =>  '-',
          :dr => dr,
          :dr_str => dr.to_s
        }
        dr_lines.append(dr_line)
        #贷方
        cr_lines = []
        cr = carrying_fee + insured_fee
        cr_line_1 =  {
          :description => "",
          #总账科目
          :gen_led =>  '返程收入',

          #明细科目
          :sub_led =>  "见附表",
          :cr => cr,
          :cr_str => cr.to_s
        }
        cr_lines.append(cr_line_1)
        #返回 贷方 借方 明细 上下文变量
        cr_detail_lines,dr_detail_lines =  build_detail_to_cash(params_search)
        return cr_lines,dr_lines,cr_detail_lines,dr_detail_lines,context
      end
      #生成返程或现付凭证
      def build_detail_to_cash(params_search = {})
        cr_detail_lines = []
        dr_detail_lines = []
        params_search[:pay_type_eq] = "CA"
        bills = self.group_by_to_org_id_and_from_org_id.search(params_search)
        group_bills = bills.group_by(&:to_org)
        group_bills.each do |to_org,bills|
          lines = []
          bills.each_with_index do |b,index|
            fee = (b.carrying_fee + b.from_short_carrying_fee + b.to_short_carrying_fee).to_i
            lines.append({
              :item1 => "",
              :item2 => "#{b.from_org.simp_name}",
              :fee => fee,
              :fee_str => fee.to_s
            })
            lines[0][:item1] =  "#{b.to_org.simp_name}" if index == 0
          end
          cr_detail_lines += lines
        end
        #返回贷方明细借方明细
        return cr_detail_lines,dr_detail_lines
      end

      #生成返程货提付凭证
      #@params_search hash 查询条件
      def build_accounting_document_to_th(params_search={},context={})
        context[:note_date] ||= Date.today.strftime("%Y-%m-%d")
        context[:note_date] = context[:note_date][5..9]
 
        context[:org_name] = '郑' if not context[:org_name]
        goods_fee = self.search(params_search).sum(:goods_fee).to_i
        params_search[:pay_type_eq] = "TH"
        #运费和保险费只计算付款方式为TH的单据
        carrying_fee = self.search(params_search).sum("carrying_fee + from_short_carrying_fee + to_short_carrying_fee").to_i
        insured_fee = self.search(params_search).sum(:insured_fee).to_i

        #借方
        dr_lines = []
        dr =  carrying_fee + goods_fee + insured_fee 
        dr_line = {
          :description => "收#{context[:org_name]}点#{context[:note_date]}返程",
          #总账科目
          :gen_led =>  '现金',
          #明细科目
          :sub_led =>  '-',
          :dr => dr,
          :dr_str => dr.to_s
        }
        dr_lines.append(dr_line)
        #贷方
        cr_lines = []
        #运费
        cr_line_1 =  {
          :description => "",
          #总账科目
          :gen_led =>  '返程运费',
          #明细科目
          :sub_led =>  "#{context[:org_name]}点运费(见附表)",
          :cr => carrying_fee,
          :cr_str => carrying_fee.to_s
        }
        cr_lines.append(cr_line_1)
        #返程货款
        cr_line_2 =  {
          :description => "",
          #总账科目
          :gen_led => '返程货款',
          #明细科目
          :sub_led =>  '',
          :cr => goods_fee,
          :cr_str => goods_fee.to_s
        }
        cr_lines.append(cr_line_2)
        #保险费
        cr_line_3 =  {
          :description => "",
          #总账科目
          :gen_led => '保险费',
          #明细科目
          :sub_led =>  '',
          :cr => insured_fee,
          :cr_str => insured_fee.to_s
        }
        cr_lines.append(cr_line_3) if insured_fee > 0

        #计算分组明细
        cr_detail_lines,dr_detail_lines = self.build_detail_to_th(params_search)
        return cr_lines,dr_lines,cr_detail_lines,dr_detail_lines,context
      end
      #生成返程货物提付明细
      #分别按照发货地货地进行分组合计
      def build_detail_to_th(params_search={},context = {})
        cr_detail_lines = []
        bills = self.group_by_from_org_id_and_to_org_id.search(params_search)
        bills.all.sort_by {|b| b.from_org.try(:order_by)}.each do |b|
          fee = (b.carrying_fee + b.from_short_carrying_fee + b.to_short_carrying_fee).to_i
          cr_detail_lines.append({
            :item1 => "#{b.from_org.simp_name}",
            :item2 => "",
            :fee => fee,
            :fee_str => fee.to_s
          })
        end
        return cr_detail_lines,[]
      end

      #根据转账代收货款生成财务凭证
      #从转账-代收货款支付清单中生成
      def build_accounting_document_transfer_payment_list(params_search={},context={})
        #按照不同的付款银行分组
        transfer_payment_lists = TransferPaymentList.search(:id_in => params_search[:payment_list_id_in]).all
        group_transfer_payment_lists = transfer_payment_lists.group_by(&:bank)

        context[:note_date] ||= Date.today.strftime("%Y-%m-%d")
        context[:note_date] = context[:note_date][5..9]

        context[:org_name] = '郑' if not context[:org_name]
        goods_fee = transfer_payment_lists.sum(&:sum_goods_fee).to_i
        params_search[:pay_type_eq] = "TH"

        #借方:应付代收货款合计
        dr_lines = []
        dr = goods_fee 
        dr_line = {
          :description => "支付#{context[:note_date]}客户货款",
          #总账科目
          :gen_led =>  '应付账款',
          #明细科目
          :sub_led =>  '-',
          :dr => dr,
          :dr_str => dr.to_s
        }
        dr_lines.append(dr_line)
        #贷方
        
        cr_lines_1 = []

        #银行存款-按照不同的银行分组
        group_transfer_payment_lists.each do |bank,lines| 
          cr_fee = lines.sum(&:sum_act_pay_fee).to_i
          cr_line =  {
            :description => "",
            #总账科目
            :gen_led =>  '',
            #明细科目
            :sub_led =>  "#{bank.name}",
            :cr => cr_fee,
            :cr_str => cr_fee.to_s
          }
          cr_lines_1.append(cr_line)
        end
        cr_lines_1.first[:gen_led] = "银行存款"

        #其他收入:手续费
        cr_lines_2 = []
        cr_fee = transfer_payment_lists.sum(&:sum_k_hand_fee).to_i
        cr_line =  {
          :description => "",
          #总账科目
          :gen_led =>  '',
          #明细科目
          :sub_led =>  "手续费",
          :cr => cr_fee,
          :cr_str => cr_fee.to_s
        }
        cr_lines_2.append(cr_line)

        #其他收入:保险费
        cr_fee = transfer_payment_lists.sum(&:sum_k_insured_fee).to_i
        cr_line =  {
          :description => "",
          #总账科目
          :gen_led =>  '',
          #明细科目
          :sub_led =>  "保险费",
          :cr => cr_fee,
          :cr_str => cr_fee.to_s
        }
        cr_lines_2.append(cr_line)
        cr_lines_2.first[:gen_led] = "其他收入"

        #营业收入
        sum_k_carrying_fee = transfer_payment_lists.sum(&:sum_k_carrying_fee).to_i
        sum_k_from_short_carrying_fee = transfer_payment_lists.sum(&:sum_k_from_short_carrying_fee).to_i
        sum_k_to_short_carrying_fee = transfer_payment_lists.sum(&:sum_k_to_short_carrying_fee).to_i
 
        cr_fee = (sum_k_carrying_fee + sum_k_from_short_carrying_fee + sum_k_to_short_carrying_fee).to_i
        cr_line =  {
          :description => "",
          #总账科目
          :gen_led =>  '营业收入',
          #明细科目
          :sub_led =>  "见附表",
          :cr => cr_fee,
          :cr_str => cr_fee.to_s
        }

        cr_lines = cr_lines_1 + cr_lines_2 + [cr_line]

        #计算分组明细
        cr_detail_lines,dr_detail_lines = self.build_detail_transfter_payment_list(params_search)
        return cr_lines,dr_lines,cr_detail_lines,dr_detail_lines,context
      end

      #根据转账代收货款生成财务凭证明细
      def build_detail_transfter_payment_list(params_search={},context = {})
        cr_detail_lines = []
        #只处理运费支付方式是货款扣的运单
        params_search[:pay_type_eq] = "KG"
        bills = self.group_by_to_org_id_and_from_org_id.search(params_search)
        bills.all.sort_by {|b| b.from_org.try(:order_by)}.each do |b|
          fee = (b.carrying_fee + b.from_short_carrying_fee + b.to_short_carrying_fee).to_i
          cr_detail_lines.append({
            :item1 => "#{b.to_org.simp_name}",
            :item2 => "#{b.from_org.simp_name}",
            :fee => fee,
            :fee_str => fee.to_s
          })
        end
        return cr_detail_lines,[]
      end
    end
  end
end
