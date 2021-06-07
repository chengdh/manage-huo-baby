# -*- encoding : utf-8 -*-
# 运单通知相关功能
module CarryingBillExtend
  module Notice
    #2012-03-01添加
    #从to_customer_phone 和 to_customer_mobile中取可用的手机号
    #NOTE 实际录单时,录单人员可能将手机号录入到固定电话一栏中去
    def sms_mobile_for_arrive
      the_mobile = nil
      the_mobile = to_customer_phone if self.to_customer_phone.present? and self.to_customer_phone.size == 11
      the_mobile = to_customer_mobile if self.to_customer_mobile.present? and self.to_customer_mobile.size == 11
      the_mobile
    end
    #得到收货人联系方式,如果有手机则优先返回手机,否则返回其他联系方式
    def phone_or_mobile_for_arrive
      phone_or_mobile = sms_mobile_for_arrive
      phone_or_mobile = self.to_customer_mobile if phone_or_mobile.blank?
      phone_or_mobile = self.to_customer_phone if phone_or_mobile.blank?
      phone_or_mobile
    end
    #得到发货人联系方式,如果有手机则优先返回手机,否则返回其他联系方式
    def phone_or_mobile_for_sender
      phone_or_mobile = sms_mobile_for_sender
      phone_or_mobile = self.from_customer_mobile if phone_or_mobile.blank?
      phone_or_mobile = self.from_customer_phone if phone_or_mobile.blank?
      phone_or_mobile
    end

    #得到发货人手机
    def sms_mobile_for_sender
      the_mobile = nil
      the_mobile = from_customer_phone if self.from_customer_phone.present? and self.from_customer_phone.size == 11
      the_mobile = from_customer_mobile if self.from_customer_mobile.present? and self.from_customer_mobile.size == 11
      the_mobile
    end

    #2012-7-2添加
    #NOTE 获取当前运单的到货提醒电话/手机
    #有手机时,返回手机
    #无手机时,返回电话
    #两者都未填写返回nil
    def notice_phone_for_arrive
      notice_phone = nil
      notice_phone = to_customer_phone if self.to_customer_phone.present?
      notice_phone = to_customer_mobile if self.to_customer_mobile.present?
      notice_phone
    end
    #生成到货提醒电话文本内容
    def calling_text_for_arrive
      Settings.notice_arrive.phone
    end
    #生成到货提醒短信文本内容
    def sms_text_for_arrive
      Settings.notice_arrive.sms % [self.to_org.try(:name),self.goods_no[6..-1],self.th_amount.to_i,self.to_org.try(:location),self.to_org.try(:phone)]
    end
    #到货通知状态
    #记录到货通知电话状态:
    def phone_notice_state_for_arrive
      state='draft'
      state = "is_failed" if self.notice_lines.any? {|line| line.calling_state.eql? "is_failed" }
      state = "is_called" if self.notice_lines.any? {|line| line.calling_state.eql? "is_called" }
      state
    end
    #到货通知短信状态
    def sms_notice_state_for_arrive
      state='draft'
      state = "is_failed" if self.notice_lines.any? {|line| line.sms_state.eql? "is_failed" }
      state = "is_sended" if self.notice_lines.any? {|line| line.sms_state.eql? "is_sended" }
      state
    end

    #送货状态
    def send_state
      send_state = "draft"
      send_state = self.send_list_line.state if self.send_list_line.present?
      send_state
    end
  end
end
