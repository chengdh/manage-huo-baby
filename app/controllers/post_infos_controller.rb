#coding: utf-8
class PostInfosController < BasePostInfosController
  defaults :resource_class => PostInfo
  #批量转账确认
  #PUT post_infos/batch_transfer
  def batch_transfer
    @post_infos = resource_class.where(:id => params[:ids])
    @post_infos.each do |p|
      p.process if p.posted?
    end
    redirect_to :back
  end
end

