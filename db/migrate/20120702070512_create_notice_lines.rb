#coding: utf-8
#创建通知信息明细
class CreateNoticeLines < ActiveRecord::Migration
  def self.up
    create_table :notice_lines do |t|
      t.references :notice,:null => false
      t.references :carrying_bill,:null => false
      t.string :from_customer_phone,:limit => 60,:null => false
      t.string :calling_text,:limit => 200,:null => false
      t.string :sms_text,:limit => 200   #可以为空,不是手机的不发送短信
      t.string :calling_state,:limit => 20,:null => false,:default => "draft"
      t.string :sms_state,:limit => 20,:null => false,:default => "draft"
      t.integer :calling_count,:default => 0
      t.integer :sms_count,:default => 0
      t.datetime :last_calling_time
      t.datetime :last_sms_time

      t.timestamps
    end
  end

  def self.down
    drop_table :notice_lines
  end
end
