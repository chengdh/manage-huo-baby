#coding: utf-8
#添加挂失 暂扣/解除暂扣 功能
class AddAdditionalStateFunctionToCarryingBill < ActiveRecord::Migration
  def change

    subject_title = "运单修改"

    subject = "CarryingBill"
    sf = SystemFunction.find_by_subject_title(subject_title)

    if sf
      #运单暂扣
      op_name = "运单暂扣"
      sfo = sf.system_function_operates.find_by_name(op_name)
      unless sfo
        function_obj = {:subject => subject,:action => "detain",:conditions => "{:additional_state => 'draft',:completed => false,:state =>['refunded_confirmed','payment_listed'] }" }
        sfo = sf.system_function_operates.create(:name => op_name,:function_obj => function_obj)
        sfo.new_function_obj = sfo.function_obj
        sfo.save!
      end
      #解除运单暂扣
      op_name = "解除运单暂扣"
      sfo = sf.system_function_operates.find_by_name(op_name)
      unless sfo
        function_obj = {:subject => subject,:action => "undetain",:conditions => "{:additional_state => 'detained',:completed => false}" }
        sfo = sf.system_function_operates.create(:name => op_name,:function_obj => function_obj)
        sfo.new_function_obj = sfo.function_obj
        sfo.save!
      end

      #挂失
      op_name = "运单挂失"
      sfo = sf.system_function_operates.find_by_name(op_name)
      unless sfo

        function_obj = {:subject => subject,:action => "report_loss",:conditions => "{:additional_state => 'draft'," +
                        ":completed => false}"}
                        #":state => ['billed','loaded','shipped','reached',"+
                        #"'distributed','deliveried','settlemented','refunded',"+
                        #"'refunded_confirmed','payment_listed']}" }
        sfo = sf.system_function_operates.create(:name => op_name,:function_obj => function_obj)
        sfo.new_function_obj = sfo.function_obj
        sfo.save!
      end
    end
  end
end
