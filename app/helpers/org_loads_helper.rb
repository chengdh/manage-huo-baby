#coding: utf-8
module OrgLoadsHelper
  def org_loads_for_select
    OrgLoad.where(:is_active => true).all.map {|b| ["#{b.name}[#{b.py}]",b.id]}
  end


end
