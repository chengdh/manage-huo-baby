# -*- encoding : utf-8 -*-
#coding: utf-8
#基于cancan的功能定义
class AbilityObj
  #分别定义了model class,操作action ,要传入can方法的hash或者block定义
  attr_accessor :subject,:action,:conditions,:block
  def initialize(subject,action,conditions=nil,block=nil)
    @subject=subject
    @action=action
    @conditions = conditions
    @block=block
  end
end

