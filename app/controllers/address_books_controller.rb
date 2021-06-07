#coding: utf-8
#通讯录
class AddressBooksController < BaseController
  def index
    super do |format|
      format.xls do
        @all_address_books = @search.all
        xls = render_to_string(:partial => "excel.html.erb",:layout => false)
        send_data xls,:filename => "address_books.xls"
      end
    end
  end
end
