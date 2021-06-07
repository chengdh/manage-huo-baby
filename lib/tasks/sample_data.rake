#coding: utf-8
require "fastercsv"

namespace :db do
  desc "对carrying_bills表进行分表操作"
  task :partition_carrying_bills => :environment do
    c = ActiveRecord::Base.connection
    #修改carrying_bill id的定义,便于进行分表操作


    c.execute("ALTER TABLE carrying_bills MODIFY id INT(11) NOT NULL")
    c.execute("ALTER TABLE carrying_bills DROP PRIMARY KEY")
    c.execute("ALTER TABLE carrying_bills ADD PRIMARY KEY (id,completed)")
    c.execute("ALTER TABLE carrying_bills MODIFY id INT(11) NOT NULL AUTO_INCREMENT")

    #以下添加mysql 分区表
    c.execute("ALTER TABLE carrying_bills
            partition by list(completed)
            (
            partition p0 values in(0),
            partition p1 values in(1)
           )")

  end
  desc "自lmis系统中导入org资料"
  task :imp_org => :environment do
    FILE_NAME=Rails.root.join('db/export/info_org.csv')
    Org.destroy_all
    rows = FasterCSV::read(FILE_NAME)
    rows.each do |row|
      org = Branch.new_with_config(:name => row[9],:simp_name => row[9],:location => row[8],:code => row[14])
      org.save!
    end
    #查找郑州总公司
    zz_branch = Branch.find_by_name("郑州总公司")
    Branch.all.each do |b|
      if ('A'..'Z').include?(b.name)
        b.update_attributes(:parent_id => zz_branch.id)
      end
    end
  end

  desc "自lmis系统中导入转账客户资料"
  task :imp_customer => :environment do
    FILE_NAME=Rails.root.join('db/export/crm_customer.csv')
    Vip.skip_callback(:create,:before,:set_code)
    Vip.destroy_all
    #银行信息,只有建设银行和浦发银行
    icbc = Bank.find_or_create_by_name_and_code("建行",8)
    icbc = Bank.find_or_create_by_name_and_code("浦发",2)

    rows = FasterCSV::read(FILE_NAME)
    rows.each do |row|
      customer_no = row[26]
      #根据客户编号得到客户所属机构和开户银行
      if customer_no.present? and (customer_no.start_with?("8") or customer_no.start_with?("2"))
        id_number = row[28]
        bank_code = customer_no[0,1]
        org_code = customer_no[1,2]
        the_bank = Bank.find_by_code(bank_code)
        the_org = Branch.find_by_code(org_code)
        if the_bank.present? and the_org.present? and !Vip.exists?(:code => customer_no) and id_number.present?
          vip = Vip.new(:org => the_org,:bank => the_bank,:name => row[8],:phone => row[11],:mobile => row[12],:bank_card => row[14],:id_number => row[28])
          vip.code = row[26]
          vip.save!
        end
      end
    end
  end

  desc "向数据库中添加示例数据"
  task :gen_test_data => :environment do
    #Rake::Task['db:reset'].invoke
    zz_branch = Branch.create!(:name => "郑州公司",
                               :simp_name => "郑",
                               :manager => "总经理",
                               :code => "zz",
                               :is_summary => true,
                               :is_yard => true,
                               :location => "南四环十八里河")
    ('A'..'Z').each do |n|
      branch = Branch.new(:name => n,:simp_name => n,:code => n)
      zz_branch.children << branch
    end
    %w[
    邱县 焦作 永年 馆陶 三门峡 洛阳 周口 肥乡 广平 成安 长治 石家庄 水冶 偃师 许昌 曲周 濮阳 新乡
    魏县 驻马店 宁晋 晋城 双桥 肉联厂 磁县 漯河 临漳 沙河 涉县 大名 鸡泽 侯马 峰峰 武安 邯郸 邢台].each_with_index do |name,index|
      Branch.create!(:name => name,:simp_name => name.first,:location => name,:code => index + 1)
    end
    #银行信息,只有建设银行和浦发银行
    Bank.create!(:name => "建行",:code => 8)
    Bank.create!(:name => "浦发",:code => 2)
    #转账手续费设置
    common_config = ConfigTransit.create(:name => "普通客户",:rate => 0.002)
    vip_config = ConfigTransit.create(:name => "VIP客户",:rate => 0.001)
  end
  #######################################################################################################3
  desc "创建默认用户"
  task :create_user => :environment do
    #创建系统默认用户
    role = Role.new_with_default(:name => 'admin')
    role.role_system_function_operates.each { |r| r.is_select = true }
    role.save!

    #管理员角色
    admin = User.new_with_roles(:username => 'admin',:real_name => "管理员",:password => 'admin',:is_admin => true)
    admin.user_orgs.each { |user_org| user_org.is_select = true }
    admin.user_roles.each {|user_role| user_role.is_select = true}
    admin.save!
    #普通用户角色
    user = User.new_with_roles(:username => 'user',:real_name => "普通用户",:password => 'user')
    user.user_orgs.each { |user_org| user_org.is_select = true }
    user.user_roles.each {|user_role| user_role.is_select = true}
    user.save!
  end
  desc "清空业务数据(保留机构/人员/权限)"
  task :clear_business_data => :environment do
    models = Dir['app/models/*.rb'].map {|f| File.basename(f, '.*').camelize.constantize } - [Ability,AbilityObj,Bank,Branch,ConfigCash,ConfigTransit,Customer,CustomerFeeInfo,CustomerFeeInfoLine,CustomerFeeInfoLineObserver,CustomerLevelConfig,Department,IlConfig,ImportedCustomer,Org,Role,RoleSystemFunctionOperate,SystemFunction,SystemFunctionOperate,User,UserOrg,UserRole,Vip,RefoundObserver,SendListModule]
    models.each {|model_class| model_class.destroy_all}
  end

  desc "生成示例数据"
  task :create_bill => :environment do
    #生成1000000张历史票
    from_org = Org.find_by_name('A')
    to_org = Org.find_by_name('邯郸')
    #生成200000张待处理票
    (1..300).each do
      ComputerBill.create!(:from_org => from_org,:to_org => to_org,:from_customer_name => "张三",:from_customer_mobile => "13679904567",:to_customer_name => "李四",:to_customer_mobile => "13676997527",:carrying_fee => 44,:goods_fee => 1000,:pay_type =>"CA",:goods_num => 3,:goods_info => "示例",:user => User.first )
    end
  end
  desc "导出机构/人员/权限/设置"
  task :export_seed_to_csv => :environment do
    [Bank,Org,ConfigCash,ConfigTransit,CustomerLevelConfig,IlConfig,Role,RoleSystemFunctionOperate,User,UserOrg,UserRole].each {|model_class| model_class.export2csv }
  end
  desc "导入机构/人员/权限/设置"
  task :import_seed_csv => :environment do
    [Bank,Org,ConfigCash,ConfigTransit,CustomerLevelConfig,IlConfig,Role,RoleSystemFunctionOperate,User,UserOrg,UserRole].each {|model_class| model_class.import_csv }
    #删除机构中无效的数据和权限中无效的数据
    UserOrg.search(:org_is_active_eq => false).each {|uo| uo.destroy}
    Org.destroy_all(:is_active => false)
  end
  desc "重设system_functions/group/operate id初始值"
  task :reload_seed => :environment do
    SystemFunctionGroup.destroy_all
    SystemFunction.destroy_all
    SystemFunctionOperate.destroy_all
    Area.destroy_all
    c = ActiveRecord::Base.connection
    c.execute("ALTER TABLE system_function_groups AUTO_INCREMENT = 1")
    c.execute("ALTER TABLE system_functions AUTO_INCREMENT = 1")
    c.execute("ALTER TABLE system_function_operates AUTO_INCREMENT = 1")
    c.execute("ALTER TABLE areas AUTO_INCREMENT = 1")
    Rake::Task['db:seed'].invoke
  end
  desc "初始化系统"
  task :init_system => :environment do
    Rake::Task['db:reload_seed'].invoke
    Rake::Task['db:import_seed_csv'].invoke
    Rake::Task['db:imp_customer'].invoke
  end
  desc "转换system_function_operate new_function_obj"
  task :convert_new_function_obj => :environment do
    #将原function_obj字段中的数据重新使用marshal序列化
    SystemFunctionOperate.all.each do |sfo|
      sfo.new_function_obj = sfo.function_obj
      sfo.save!
    end
  end

  desc "修改错误票号"
  task :fix_error_goods_nos => :environment do
    old_goods_nos = %w[120620V漯河50-23 120620V洛阳52-3 120620V洛阳55-4 120630V广平96-16 120630V邢台111-5 120630V磁县116-2 120701V鑫港99-1 120702V广平96-13 120706V魏县76-2 120707V永年56-1 120707V永年57-2 120707V武安58-1 120707V长治63-1 120708V磁县87-4 120711V磁县66-5 120712V磁县80-4 120717V磁县88-2 120723V大名87-2 120724V永年53-1 120724V邢台56-1 120801V磁县85-7 120811V水冶82-3 120813V永年53-1 120813V鑫港106-5 120813V武安107-1 120813V晋城108-3 120813V鑫港109-1 120813V长治112-5 120813V鑫港113-4 120813V磁县119-3 120814V清河63-1 120814V巨鹿62-1 120814V邯郸109-3 120814V峰峰110-5 120814V峰峰111-8 120814V永年112-1 120818V成安61-3 120818V永年63-1 120818V魏县62-1 120818V鑫港74-5 120818V临漳78-2 120818V鑫港82-2 120818V邢台84-2 120818V磁县90-6 120818V邢台96-1 120822V鑫港60-2 120822V峰峰61-2 120822V邢台63-1 120822V鑫港64-12 120822V水冶65-1 120822V魏县67-2 120822V武安68-1 120822V临漳69-12 120822V邢台70-3 120822V磁县71-2 120822V峰峰72-1 120822V鑫港73-1 120822V临漳74-1 120822V临漳75-2 120822V峰峰76-2 120822V魏县77-2 120822V鑫港79-16 120822V鑫港80-3 120822V鑫港81-2 120822V鑫港82-4 120822V鑫港83-1 120822V魏县84-1 120822V成安86-1 120822V鑫港87-6 120822V峰峰88-15 120822V水冶89-2 120822V鑫港90-8 120822V峰峰91-1 120822V长治92-8 120822V水冶93-3 120822V长治94-4 120822V水冶95-3 120822V水冶96-1 120822V水冶97-2 120822V鑫港98-4 120822V成安99-2 120822V鑫港100-8 120822V鑫港102-5 120822V广平103-2 120822V水冶104-3 120822V鑫港105-6 120822V邢台106-1 120822V鑫港107-11 120822V鑫港105-5]
    old_goods_nos.each do |old_goods_no|
      new_goods_no = "#{old_goods_no[0..7]}#{old_goods_no[10..-1]}"
      bill = HandBill.find_by_goods_no(new_goods_no)
      fixed_goods_no = "#{old_goods_no[0..7]}#{old_goods_no[9..-1]}"
      bill.update_attributes(:goods_no => fixed_goods_no,:note => old_goods_no) if bill
    end
  end
  desc "修改物品单价"
  task :change_goods_cat_fee_config => :environment do
    goods_cats = %w[床头 电器（皮） 电子琴 服装包 钢架 锅 美容品 模特（工艺） 牛仔裤 配件 气泵 手机 手机（配件） 探照灯 铁架 线 亚克力板 颜料 扬声器]
    goods_cats_fee =[55,150,110,130,270,50,130,170,190,300,280,1100,1500,200,150,200,10,250,95]

    goods_cats.each_with_index do |cat,i|
      c = GoodsCat.find_by_name(cat)
      GoodsCatFeeConfigLine.update_all({:unit_price => goods_cats_fee[i]},:goods_cat_id => c.id)
    end
  end
end
