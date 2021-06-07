# -*- encoding : utf-8 -*-
module AreasHelper
  def areas_for_select
    Area.where(:is_active => true).order('order_by ASC').all.map {|b| ["#{b.name}",b.id]}
  end
end

