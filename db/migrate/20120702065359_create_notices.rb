#coding: utf-8
#创建通知信息表
class CreateNotices < ActiveRecord::Migration
  def self.up
    create_table :notices do |t|
      t.references :org,:null => false
      t.references :load_list
      t.references :user
      t.date :bill_date
      t.string :state,:limit => 20,:null => false,:default => 'draft'
      t.text :note
      t.string :bymanual,:limit => 2 #电话通知客户端程序需要字段

      t.timestamps
    end
    #以下创建digitaction表,电话通知客户端程序使用
    c = ActiveRecord::Base.connection
    create_table_sql = <<SQL
    CREATE TABLE digitaction (
      id int(10) unsigned NOT NULL AUTO_INCREMENT,
      digit varchar(45) DEFAULT NULL,
      action varchar(45) DEFAULT NULL,
      remark varchar(45) DEFAULT NULL,
      name varchar(45) DEFAULT NULL,
      PRIMARY KEY (id)
    )

SQL

    #插入digitaction表预置数据
    insert_sqls =["INSERT INTO digitaction  (digit,action,remark,name) VALUES ('0', '挂断', '', '')"]
    insert_sqls << "INSERT INTO digitaction  (digit,action,remark,name)  VALUES ('1', '挂断', '', '')"
    insert_sqls << "INSERT INTO digitaction  (digit,action,remark,name) VALUES ('2', '挂断', '', '')"
    insert_sqls << "INSERT INTO digitaction (digit,action,remark,name)  VALUES ('3', '挂断', '', '')"
    insert_sqls << "INSERT INTO digitaction  (digit,action,remark,name) VALUES ('4', '挂断', '', '')"
    insert_sqls << "INSERT INTO digitaction  (digit,action,remark,name) VALUES ('5', '挂断', '', '')"
    insert_sqls << "INSERT INTO digitaction  (digit,action,remark,name) VALUES ('6', '挂断', '', '')"
    insert_sqls << "INSERT INTO digitaction  (digit,action,remark,name) VALUES ('7', '挂断', '', '')"
    insert_sqls << "INSERT INTO digitaction  (digit,action,remark,name) VALUES ('8', '挂断', '', '')"
    insert_sqls << "INSERT INTO digitaction  (digit,action,remark,name) VALUES ('9', '挂断', '', '')"
    insert_sqls << "INSERT INTO digitaction  (digit,action,remark,name) VALUES ('*', '挂断', '', '')"
    insert_sqls << "INSERT INTO digitaction  (digit,action,remark,name) VALUES ('#', '挂断', '', '')"
    c.execute create_table_sql
    insert_sqls.each {|sql| c.execute sql }

  end

  def self.down
    drop_table :notices
    drop_table :digitaction
  end
end
