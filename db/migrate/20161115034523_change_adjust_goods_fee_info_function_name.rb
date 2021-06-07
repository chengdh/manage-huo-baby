#coding: utf-8
class ChangeAdjustGoodsFeeInfoFunctionName < ActiveRecord::Migration
  def up
    title = "货款调整"
    sf = SystemFunction.find_by_subject_title(title)
    if sf.present?
      sf.update_attributes(:subject_title => "货款/信息调整")
    end
  end

  def down
  end
end
