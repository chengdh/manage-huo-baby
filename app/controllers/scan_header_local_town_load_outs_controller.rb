#coding: utf-8
#同城-装卸组出库单
class ScanHeaderLocalTownLoadOutsController < ScanHeadersController
  defaults :resource_class => ScanHeaderLocalTownLoadOut

  #PUT scan_header_local_town_load_out/:id/ship
  #发车
  def ship
    @scan_header_local_town_load_out = ScanHeaderLocalTownLoadOut.find(params[:id])
    @scan_header_local_town_load_out.ship
    flash[:success] = "发车操作成功!"
    redirect_to :action => :show
  end


end
