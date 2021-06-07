# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.select_org_multi_in_region_form').multipleSelect(
    placeholder : "请选择机构",
    multiple: true,
    filter: true,
    selectAll: false
  )

  #设置已选择的机构
  for el,idx in $("#select_region_org")
    pre_orgs = $(el).data("orgs")
    org_ids = (org.id for org in pre_orgs)
    $(el).multipleSelect("setSelects",org_ids)

  $("#region_form").on("submit", ->
    for el_select_region_org,idx in $("#select_region_org")
      model_name = "region"
      field_name = "region_orgs"

      #先删除所有已选择的机构数据
      destroy_orgs = $(el_select_region_org).data("orgs")
      for d_org,d_idx in destroy_orgs
        el_id = $("<input type='hidden' name='#{model_name}[#{field_name}_attributes][#{d_idx}][org_id]' value='#{d_org.id}' />")
        el_destroy = $("<input type='hidden' name='#{model_name}[#{field_name}_attributes][#{d_idx}][_destroy]' value='true' />")
        $(this).append(el_id)
        $(this).append(el_destroy)

      #再保存选择的机构
      org_ids = $(el_select_region_org).multipleSelect("getSelects")
      for org_id,org_idx in org_ids
        el_org = $("<input type='hidden' name='#{model_name}[#{field_name}_attributes][#{org_idx}][org_id]' value='#{org_id}' />")
        $(this).append(el_org)
  )

