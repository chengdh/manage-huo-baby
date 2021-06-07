#coding: utf-8
#创建生成到货通知清单功能
class AddBuildNoticeFunctionForLoadList < ActiveRecord::Migration
  def self.up

    sf = SystemFunction.find_by_subject_title('到货清单管理')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('生成到货通知清单')
      sfo.function_obj = {
        :subject => "LoadList",
        :action => :build_notice,
        :conditions => "{:state => 'reached'}"
      }
      sfo.save!
    end

  end

  def self.down
  end
end
