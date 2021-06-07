# -*- encoding : utf-8 -*-
module CustomerLevelConfigsHelper
  def customer_levels_for_select
    CustomerLevelConfig.levels.map {|k,v| [v,k]}
  end
end

