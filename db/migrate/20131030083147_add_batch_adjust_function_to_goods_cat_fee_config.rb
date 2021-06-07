#coding: utf-8
#添加批量调整功能到货物分类费用处理中
class AddBatchAdjustFunctionToGoodsCatFeeConfig < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('货物分类运费设置')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('批量调整')
      sfo.function_obj = {
        :subject => "GoodsCatFeeConfig",
        :action => :show_batch_adjust
      }
      sfo.new_function_obj = {
        :subject => "GoodsCatFeeConfig",
        :action => :show_batch_adjust
      }

      sfo.save!
    end
  end
  def down

  end
end
