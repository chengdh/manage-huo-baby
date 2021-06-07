#coding: utf-8
#外部中转收货清单
class ArriveOutterTransitLoadListsController < ArriveLoadListsController
  defaults :resource_class => OutterTransitLoadList, :collection_name => 'outter_transit_load_lists', :instance_name => 'outter_transit_load_list'
  #先跳过基类的验证,然后重写自己的验证
  skip_authorize_resource
  authorize_resource :class => "OutterTransitLoadList",:instance_name => "outter_transit_load_list"
end
