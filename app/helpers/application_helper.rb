# -*- encoding : utf-8 -*-
#coding: utf-8
module ApplicationHelper
  #排序辅助方法
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current_sort_column #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "desc") ? "asc" : "desc"
    link_to title, params.merge(:sort => column, :direction => direction,:page => nil), {:class => css_class,:title => "点击可排序"}
  end
  #金额转中文大写
  def convertNumToChinese(num)
    chineseNumArr=['零','壹','贰','叁','肆','伍','陆','柒','捌','玖']
    chinesePosArr=['万','仟','佰','拾','亿','仟','佰','拾','万','仟','佰','拾','元','角','分']
    chineseNum=''
    chinesePos=''
    strChinese=''
    nzero=0
    strNum=(num*100).abs.to_i.to_s
    i=0
    length=strNum.length
    posValue=0
    pos=chinesePosArr.length-length
    while i<length
      posValue=strNum[i].chr.to_i

      if(i!=(length-3) && i!=(length-7) && i!=(length-11) && i!=(length-15))
        if(posValue==0)
          chineseNum=''
          chinesePos=''
          nzero+=1
        else
          if(nzero!=0)
            chineseNum=chineseNumArr[0]+chineseNumArr[posValue]
            chinesePos=chinesePosArr[pos+i]
            nzero=0
          else
            chineseNum=chineseNumArr[posValue]
            chinesePos=chinesePosArr[pos+i]
            nzero=0
          end
        end
      else
        if(posValue!=0 && nzero!=0)
          chineseNum=chineseNumArr[0]+chineseNumArr[posValue]
          chinesePos=chinesePosArr[pos+i]
          nzero=0
        else
          if(posValue!=0 && nzero==0)
            chineseNum=chineseNumArr[posValue]
            chinesePos=chinesePosArr[pos+i]
            nzero=0
          else
            if(length>=11)
              chineseNum=''
              nzero+=1
            else
              chineseNum=''
              chinesePos=chinesePosArr[pos+i]
              nzero+=1
            end
          end
        end
      end
      if(i==(length-11) || i==(length-3))
        chinesePos=chinesePosArr[pos+i]
      end
      strChinese=strChinese+chineseNum+chinesePos
      if(i==(length-1) && posValue==0)
        strChinese=strChinese+'整'
      end
      i+=1
    end
    strChinese ='负' + strChinese if num < 0
    strChinese
  end
  #根据索引生成页面上的序号
  def order_no(index,cur_page = 1,rows_per_page = 30)
    cur_page = 1 if cur_page.blank?
    rows_per_page = 30 if rows_per_page.blank?
    cur_page = cur_page.to_i if cur_page.kind_of?(String)
    rows_per_page = cur_page.to_i if rows_per_page.kind_of?(String)
    index+1 + rows_per_page*(cur_page - 1)
  end
  #将foreign_key 生成association
  def foreign_key_to_association(column)
    ret = column.to_s.gsub!(/_id/,"")
    ret = column if ret.blank?
    ret.to_sym
  end
  #生成前后12个月的select
  def months_for_select
    ret = []
    (1..36).each do |step|
      mth = step.months.ago
      ret << [mth.strftime('%Y年%m月'),mth.strftime('%Y%m')]
    end
    ret
  end
  #按照年份对月份分组
  def months_options_groups
    ret = []
    (1..36).each do |step|
      mth = step.months.ago
      ret << [mth.strftime('%Y年%m月'),mth.strftime('%Y%m')]
    end
    group_months = ret.group_by {|m| m.first[0..3]}.to_a
    option_groups_from_collection_for_select(group_months,:last,:first,:last,:first)
  end
  #各个业务模块中hidden_fields和show_fields的显示
  #参数1：cp_path  默认值为当前controller的controller_name 可覆盖
  #返回: {:show_fields => "",:hidden_fields => ""}
  def show_or_hidden_fields(cp_name_or_key = controller_name)
    search_key = cp_name_or_key.to_sym
    default_show_fields = %w[.order_no .bill_no .goods_no .from_to .customer .pay_type .carrying_fee .goods_fee .note]
    #default_hide_fields = %w[.insured_fee .carrying_fee_th .k_carrying_fee .insured_fee_th .k_insured_fee .from_short_carrying_fee .from_short_carrying_fee_th .k_from_short_carrying_fee .to_short_carrying_fee .to_short_carrying_fee_th .k_to_short_carrying_fee .carrying_fee_total .carrying_fee_th_total .k_carrying_fee_total .transit_carrying_fee .transit_hand_fee .agent_carying_fee .th_amount .k_hand_fee .act_pay_fee .transit_company .transit_bill_no .transit_to_phone,.state .from_short_fee_state .to_short_fee_state .send_date .stranded_days .deliver_date .pay_date .phone_notice_state_for_arrive .sms_notice_state_for_arrive]
    controller_show_or_hide_fields = {
      :load_lists => {
        :show_fields => %w[.insured_fee .carrying_fee_total .carrying_fee_1st .carrying_fee_2st],
        :hide_fields => []
      },
      :outter_transit_load_lists => {
        :show_fields => %w[.insured_fee .carrying_fee_total .carrying_fee_1st .carrying_fee_2st],
        :hide_fields => []
      },
      #内部中转
      :from_org_inner_transit_load_lists => {
        :show_fields => %w[.insured_fee .carrying_fee_total .carrying_fee_1st .carrying_fee_2st],
        :hide_fields => []
      },
      :transit_org_inner_transit_load_lists => {
        :show_fields => %w[.insured_fee .carrying_fee_total .carrying_fee_1st .carrying_fee_2st],
        :hide_fields => []
      },
      :to_org_inner_transit_load_lists => {
        :show_fields => %w[.insured_fee .carrying_fee_total .carrying_fee_1st .carrying_fee_2st],
        :hide_fields => []
      },

      :arrive_load_lists => {:show_fields => %w[.insured_fee .carrying_fee_total],:hide_fields => []},
      :arrive_outter_transit_load_lists => {:show_fields => %w[.insured_fee .carrying_fee_total],:hide_fields => []},
      :distribution_lists => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount]
      },

      :inner_transit_distribution_lists => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount]
      },

      :deliver_infos => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount]
      },
      #内部中转提货
      :inner_transit_deliver_infos => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount]
      },

      #货物中转
      :transit_infos => {
        :hide_fields => %w[.carrying_fee .note],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount .transit_to_phone .transit_bill_no .transit_company .transit_carrying_fee]
      },
      #货物中转form
      :transit_info_form => {
        :hide_fields => %w[.note],
        :show_fields => %w[.insured_fee .th_amount .transit_carrying_fee_edit .transit_to_phone_edit .transit_bill_no_edit]
      },
      #中转提货
      :transit_deliver_infos => {
        :hide_fields => %w[.carrying_fee .note .customer],
        :show_fields => %w[.carrying_fee_th_total .th_amount .transit_to_phone .transit_bill_no .transit_company .transit_carrying_fee .transit_hand_fee]
      },
      :transit_deliver_info_form => {
        :hide_fields => %w[.carrying_fee .note .customer],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount .transit_hand_fee_edit .transit_to_phone .transit_bill_no .transit_company]
      },

      :settlements => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount .transit_carrying_fee .transit_hand_fee]
      },
      #外部中转-结算员交款清单
      :outter_transit_settlements => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount .transit_carrying_fee .transit_hand_fee]
      },

      #内部中转-结算员交款清单
      :inner_transit_settlements => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount .transit_carrying_fee .transit_hand_fee]
      },


      :refounds => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount .transit_carrying_fee .transit_hand_fee]
      },
      #外部中转-返款清单
      :outter_transit_refunds => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount .transit_carrying_fee .transit_hand_fee]
      },
      #内部中转-返款清单
      :from_org_inner_transit_refunds => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount .transit_carrying_fee .transit_hand_fee]
      },
      :transit_org_inner_transit_refunds => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount .transit_carrying_fee .transit_hand_fee]
      },
      :to_org_inner_transit_refunds => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount .transit_carrying_fee .transit_hand_fee]
      },

      :receive_refounds => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount .transit_carrying_fee .transit_hand_fee]
      },
      :receive_outter_transit_refunds => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.insured_fee_th .carrying_fee_th_total .th_amount .transit_carrying_fee .transit_hand_fee]
      },

      :cash_payment_lists => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee,.transit_hand_fee .act_pay_fee]
      },
      :outter_transit_cash_payment_lists => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee,.transit_hand_fee .act_pay_fee]
      },
      :inner_transit_cash_payment_lists => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee,.transit_hand_fee .act_pay_fee]
      },

      :transfer_payment_lists => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee,.transit_hand_fee .act_pay_fee]
      },
      :outter_transit_transfer_payment_lists => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee,.transit_hand_fee .act_pay_fee]
      },
      :inner_transit_transfer_payment_lists => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee,.transit_hand_fee .act_pay_fee]
      },

      :cash_pay_infos => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee,.transit_hand_fee .act_pay_fee]
      },
      :outter_transit_cash_pay_infos => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee,.transit_hand_fee .act_pay_fee]
      },
      :inner_transit_cash_pay_infos => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee,.transit_hand_fee .act_pay_fee]
      },

      :transfer_pay_infos => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee,.transit_hand_fee .act_pay_fee]
      },
      :outter_transit_transfer_pay_infos => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee,.transit_hand_fee .act_pay_fee]
      },
      :inner_transit_transfer_pay_infos => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee,.transit_hand_fee .act_pay_fee]
      },

      :post_infos => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee .transit_hand_fee .act_pay_fee]
      },
      :outter_transit_post_infos => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee .transit_hand_fee .act_pay_fee]
      },
      :inner_transit_post_infos => {
        :hide_fields => %w[.carrying_fee],
        :show_fields => %w[.k_insured_fee .k_carrying_fee_total .k_hand_fee .transit_hand_fee .act_pay_fee]
      },

      :short_fee_infos => {
        :hide_fields => %w[.carrying_fee .note .goods_fee],
        :show_fields => %w[.from_short_carrying_fee .to_short_carrying_fee]
      },
      :from_short_fee_infos => {
        :hide_fields => %w[.carrying_fee .note .goods_fee],
        :show_fields => %w[.from_short_carrying_fee .to_short_carrying_fee]
      }

    }

    #如果没有设置对应的字段显示,则添加一个默认不使用的css class,主要是为了防止前端json出错
    return {:show_fields => ".not-use",:hide_fields => ".not-use"} if controller_show_or_hide_fields[search_key].blank?

    show_fields = default_show_fields + controller_show_or_hide_fields[search_key][:show_fields]
    show_fields.uniq!
    show_fields -= controller_show_or_hide_fields[search_key][:hide_fields]
    {
      :show_fields => show_fields.join(','),
      :hide_fields => controller_show_or_hide_fields[search_key][:hide_fields].join(",")
    }
  end
  #将show_or_hidden_fields转换为字符串
  #其形式类似与 "a" : "1","b" : "2" 在设置html element的data属性时使用
  def show_or_hidden_fields_to_str(c_name = controller_name)
    ret_arr = show_or_hidden_fields(c_name).map {|k,v| "\"#{k}\" : \"#{v}\""}
    #此处为了防止ret_attr为空
    ret_arr.join(",")
  end

  #去除render 中的回车换行和空格
  def minify_html(html_str)
    html_str.gsub!(/\n/,"")
  end

  #费用类别选择
  def fee_types_for_select
    [
      ['运费','carrying_fee'],['货款','goods_fee'],['保险费','insured_fee'],
      ['手续费','k_hand_fee'],['接货费','from_short_carrying_fee'],['送货费','to_short_carrying_fee'],
      ['管理费','manage_fee'],['货物件数','goods_num',],['票据数','bill_count']
    ]
  end
end

