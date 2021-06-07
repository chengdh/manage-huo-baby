#coding: utf-8
#修正validates_associated错误信息显示不完整的问题
#参考http://archived.rpheath.com/posts/412-a-better-validates-associated
#针对rails3做了修改
module ActiveRecord::Validations
  class AssociatedValidator
    def validate_each(record, associate_name, value)
      (value.respond_to?(:each) ? value : [value]).each do |rec|
        if rec && !rec.valid?
          rec.errors.each do |key, err_value|
            if rec.respond_to? :bill_no
              record.errors.add(key, "单据号:#{rec.bill_no} #{err_value}")
            else
              record.errors.add(key, err_value)
            end
          end
        end
      end
    end
  end
end
