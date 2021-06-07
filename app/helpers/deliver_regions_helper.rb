module DeliverRegionsHelper
  #送货区域选择
  def deliver_regions_for_select(org_id = nil)
    ret = DeliverRegion.where(:is_active => true).map {|dr| [dr,dr.id]} if org_id.blank?
    ret = DeliverRegion.where(:is_active => true,:org_id => org_id).map {|dr| [dr,dr.id]} if org_id.present?
    ret
  end
end
