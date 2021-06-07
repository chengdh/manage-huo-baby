#coding: utf-8
#内部中转装卸组出库单
class ScanHeaderInnerTransitLoadOutsController < ScanHeadersController
  defaults :resource_class => ScanHeaderInnerTransitLoadOut

  #PUT scan_header_inner_transit_load_out/:id/ship
  #发车
  def ship
    @scan_header_inner_transit_load_out = ScanHeaderInnerTransitLoadOut.find(params[:id])
    @scan_header_inner_transit_load_out.ship
    flash[:success] = "发车操作成功!"
    redirect_to :action => :show
  end

end
