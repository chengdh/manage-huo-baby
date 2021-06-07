# -*- encoding : utf-8 -*-
#用于处理通知 公告信息的显示
class MessagesController < BaseController
  table :title,:user,:human_state_name
  #GET messages/:id/show
  #显示详细信息窗口
  def show
    super do |format|
      format.js {render :partial => "show"}
    end
  end

  #PUT messages/:id/update_view_count
  #更新消息查看记录
  def update_view_count
    @message = Message.find(params[:id])
    # #保存查看记录
    # message_history = MessageHistory.find_or_create_by_message_id_and_user_id(@message.id,current_user.id)
    # message_history.update_attributes(:view_count => message_history.view_count + 1)
    # respond_to do |format|
    #   format.html
    #   format.js  {render :partial => "show"}
    # end
  end

  #PUT messages/:id/update_view_count
  #更新新闻查看次数
  def update_view_count
    @message = Message.find(params[:id])
    #保存查看记录
    message_history = MessageHistory.find_or_create_by_message_id_and_user_id(@message.id,current_user.id)
    message_history.update_attributes(:view_count => message_history.view_count + 1)
  end


  #PUT messages/:id/publish
  #通知发布
  def publish
    @message = Message.find(params[:id])
    @message.publish
    flash[:notice] = "通知发布成功!"
    render :action => :show
  end
  #PUT messages/:id/unpublish
  #通知-草稿
  def unpublish
    @message = Message.find(params[:id])
    @message.unpublish
    flash[:notice] = "通知已修改为草稿状态!"
    render :action => :show
  end
end
