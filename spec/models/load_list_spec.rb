#coding: utf-8
require 'spec_helper'

describe LoadList do
  before(:each) do
    @load_list = Factory(:load_list_with_bills)
    @transit_load_list = Factory(:transit_load_list)
  end
  it "应能正确保存装车清单" do
    @load_list.save!
  end
  it "必须录入发货地和到货地字段才能正确保存" do
    @load_list.from_org = nil
    @load_list.to_org = nil
    @load_list.should_not be_valid
  end
  it "装车单保存后,其状态应为'已开票'" do
    @load_list.should be_billed
  end

  it "装车单保存后,其状态应为'已装车'" do
    @load_list.process
    @load_list.should be_loaded
    @load_list.carrying_bills.first.should be_loaded
  end
  it "装车单发出后,其状态应为'已发出'" do
    @load_list.process

    @load_list.process
    @load_list.should be_shipped
    @load_list.carrying_bills.first.should be_shipped
  end
  it "装车单到货确认后,其状态应变为'已到货'" do
    @load_list.process
    @load_list.process

    @load_list.process
    @load_list.should be_reached

    @load_list.carrying_bills.first.should be_reached
  end

  ######中转处理####################
  it "中转装车单保存后,其状态为’已发出" do
    (1..2).each {@transit_load_list.process}
    @transit_load_list.should be_shipped
  end
  it "中转装车单中转地确认后,其状态为’中转已到货" do
    (1..3).each {@transit_load_list.process}
    @transit_load_list.should be_transit_reached
  end
  it "中转装车单中转地发货后,其状态为’中转已发货" do
    (1..4).each {@transit_load_list.process}
    @transit_load_list.should be_transit_shipped
  end
  it "中转装车单到达目的地后,其状态为’已到货" do
    (1..5).each {@transit_load_list.process}
    @transit_load_list.should be_reached
  end

  it "scope from_org_transit_bills should correct" do
    LoadList.from_org_transit_bills([1]).explain.should_not be_blank
  end
  it "scope transit_org_transit_bills should correct" do
    LoadList.transit_org_transit_bills([1]).explain.should_not be_blank
  end
  it "scope to_org_transit_bills should correct" do
    LoadList.to_org_transit_bills([1]).explain.should_not be_blank
  end
end

