#coding: utf-8
#投票系统基础类
class BaseVoteConfigsController < BaseController
  table :name,:mth,:expire_date
  #GET vote_configs/new
  def new
    vote_ivar = resource_class.new
    10.times.each do
      vi = VotableItem.new
      viorg = VotableItemOrg.new(:org => Org.first)
      vi.votable_item_orgs << viorg

      vote_ivar.votable_items << vi
    end
    set_resource_ivar(vote_ivar)
  end

  #GET vote_configs/show_current_vote
  #显示当前投票界面
  def new_vote
    vote_ivar = resource_class.where(:mth => Date.today.strftime("%Y%m")).search(:expire_date_gte => Date.today).try(:first)
    set_resource_ivar(vote_ivar)

    if vote_ivar.blank?
      flash[:error] = "没有找到投票设置,请先进行投票设置!"
      redirect_to :back
    elsif current_user.find_votes(:vote_scope => vote_ivar.id).size > 0
      flash[:error] = "您已保存了投票信息!"
      @vote_items = current_user.find_votes(:vote_scope => vote_ivar.id)
      render :action => :show_vote_info
    end
  end

  #POST vote_configs/save_vote
  #保存投票信息
  def save_vote
    vote_ivar = resource_class.find(params[:vote_scope])
    set_resource_ivar(vote_ivar)
    vote_scope = params[:vote_scope]
    vote_item_ids = params[:vote_items]
    vote_rates = params[:vote_rates]
    #保存投票信息
    vote_item_ids.each_with_index do |item_id,idx|
      vi = VotableItem.find(item_id)
      vi.vote_by :voter => current_user,:vote_weight =>  vote_rates[idx],:vote_scope => vote_scope
    end
    flash[:success] = "保存投票信息成功!"
  end

  #GET vote_config/:id/show_vote_info
  #显示当前用户的投票情况
  def show_vote_info
    vote_ivar = resource_class.find(params[:id])
    set_resource_ivar(vote_ivar)
    @vote_items = current_user.find_votes(:vote_scope => vote_ivar.id)
  end

  #GET vote_configs/current_user_vote_index
  #得到当前用户的投票信息列表
  def current_user_vote_index
    votes = current_user.find_votes.group(:vote_scope)
    ids = votes.map {|v| v.id}
    vote_configs_ = resource_class.find(ids)
    set_collection_ivar(vote_configs)
  end

  #GET vote_configs/:id/show_sum
  #显示汇总得分
  def show_sum
    vote_ivar = resource_class.find(params[:id])
    set_resource_ivar(vote_ivar)
  end
end
