#coding: utf-8
class PriceTablesController < BaseController
  def index
    super do |format|
      format.xls do
        @all_price_tables = @search.all
        xls = render_to_string(:partial => "excel.html.erb",:layout => false)
        send_data xls,:filename => "price_tables.xls"
      end
    end
  end
end
