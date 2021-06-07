#coding: utf-8
#修正联合主键时lhm的问题
module Lhm
  class Table
    attr_reader :name, :columns, :indices, :pk, :ddl

    def initialize(name, pk = "id", ddl = nil)
      @name = name
      @columns = {}
      @indices = {}
      @pk = pk
      #此处修正复合主键时无法处理的问题
      @pk = pk.first if pk.is_a? Array
      @ddl = ddl
    end
  end
end
