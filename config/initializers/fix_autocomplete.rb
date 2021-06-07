# -*- encoding : utf-8 -*-
#coding: utf-8
#修正当model类有继承时,autocomplete不起作用的问题
module Rails3JQueryAutocomplete
  module Helpers
    def get_implementation(object) 
      :activerecord
    end
  end
end

