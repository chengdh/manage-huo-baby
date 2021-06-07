#coding: utf-8
module RegionsHelper
  def regions_for_select
    Region.where(:is_active => true).all.map {|b| ["#{b.name}",b.id]}
  end
end
