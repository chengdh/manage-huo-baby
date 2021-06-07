#coding: utf-8
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

#set :output, "~/cron_log.log"
set :output, {:standard => 'log/cron.log'}
job_type :my_runner,  "cd :path && bundle exec rails runner -e :environment ':task' :output"

# 每月1号 2:30am 执行导入客户资料的动作
every '30 3 1 * *',:roles => [:app] do
  my_runner "ImportedCustomer.import"
end

#每月1号 3:30分 执行生成统计曲线数据
every '30 4 1 * *',:roles => [:app] do
  my_runner "RptFromOrgMth.generate_data"
end

#每天早上2:30分执行生成欠款提货清单的动作
#every '30 2 * * *',:roles => [:app] do
#  my_runner "DebtBill.create_yesterday_debt_bills"
#end
#每天凌晨4点执行实提货款统计处理
every '30 4 * * *',:roles => [:app] do
  my_runner "CarryingFeeThRpt.generate_rpt"
end

#每天11:30分执行自动发货操作
every '44 16 * * *',:roles => [:app] do
  my_runner "LoadList.auto_load_and_send(1)"
end
