#coding: utf-8
class ScanHeaderTeamsController < ScanHeadersController
  defaults :resource_class => ScanHeaderTeam

  #GET scan_header_teams/report_workload
  #装卸工作量统计
  def report_workload
    @scan_lines = ScanLine.search(params[:search]).all
  end

  #GET scan_header_teams/export_excel
  #导出excel
  def export_excel
    @scan_lines = ScanLine.search(params[:search]).all
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "scan_header_team.xls"
  end


  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end
end
