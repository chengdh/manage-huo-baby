#coding: utf-8
#基于条形码的装车清单
class LoadListWithBarcodesController < BaseController
  protect_from_forgery :except => [:confirm,:create,:update]
  skip_before_filter :authenticate_user!
  skip_load_and_authorize_resource
  #GET load_list_with_barcodes
  def index
    @search = end_of_association_chain.search(params[:search])
    set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
    respond_to do |format|
      format.html
      format.xml {render :xml => @load_list_with_barcodes.to_xml(:include => :load_list_with_barcode_lines,:skip_types => true,:dasherize => false)}
    end

  end
  #POST load_list_with_barcodes
  #创建条码装车单
  def create
    @load_list_with_barcode = LoadListWithBarcode.new(params[:load_list_with_barcode])
    create! do |format|
      format.html
      format.xml {render :xml => @load_list_with_barcode.to_xml(:skip_types => true,:dasherize => false,:methods => [:valid?])}
    end
  end
  #确认条码装车单
  #PUT load_list_with_barcode/:id/confirm
  def confirm
    @load_list_with_barcode = resource_class.find(params[:id])
    @load_list_with_barcode.update_attributes(params[:load_list_with_barcode])
    respond_to do |format|
      format.html
      format.xml {render :xml => @load_list_with_barcode.to_xml(:skip_types => true,:dasherize => false,:methods => [:valid?])}
    end
  end
end
