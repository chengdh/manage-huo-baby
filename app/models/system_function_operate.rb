# -*- encoding : utf-8 -*-
#coding: utf-8
class SystemFunctionOperate < ActiveRecord::Base
  belongs_to :system_function
  #FIXME 使用mashal序列化该对象,mashal 比YAML性能块10倍以上
  marshaled :new_function_obj
  serialize :function_obj
end

