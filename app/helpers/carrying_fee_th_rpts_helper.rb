#coding: utf-8
module CarryingFeeThRptsHelper
  def title
    year = params[:search].try(:[],:year)
    mth = params[:search].try(:[],:mth)
    year = Date.today.year if year.blank?
    mth = Date.today.month if mth.blank?
    "#{year}年#{mth}月实提运费统计表"
  end
end
