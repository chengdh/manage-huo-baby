#coding: utf-8
class AddGoodsCatFeeConfigFunction < ActiveRecord::Migration
  def up
    group_name = "系统管理"
    #################################分理处/分公司管理################################################
    subject_title = "货物分类运费设置"
    subject = "GoodsCatFeeConfig"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'goods_cat_fee_configs_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看"} ,
        :create => {:title => "新建"},
        :update =>{:title =>"修改"},
        :destroy => {:title => "删除"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
    sf = SystemFunction.find_by_subject_title('货物分类运费设置')
    sf.destroy if sf
  end
end
