#coding: utf-8
#装卸组出库
class ScanHeaderLoadOutsController < ScanHeadersController
  defaults :resource_class => ScanHeaderLoadOut
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end


  #PUT scan_header_load_out/:id/ship
  #发车
  def ship
    @scan_header_load_out = ScanHeaderLoadOut.find(params[:id])
    @scan_header_load_out.ship
    flash[:success] = "发车操作成功!"
    redirect_to :action => :show
  end
end
