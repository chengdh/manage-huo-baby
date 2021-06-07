# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  multi_select = $('.select_org_multi_for_vote').multipleSelect(
    placeholder : "请选择分理处/分公司",
    multiple: true,
    selectAll: false,
    onClose: ->
      # for el_org,idx in $(".select_org_multi_for_vote")
      #   org_ids = $(el_org).multipleSelect("getSelects")
      #   for org_id,org_idx in org_ids
      #     el_votable_item_org = $("<input type='hidden' name='vote_config_with_org[votable_items_attributes][#{idx}][votable_item_orgs_attributes][#{org_idx}][org_id]' value='#{org_id}' />")
      #     $("#vote_config_with_org_form").append(el_votable_item_org)
  )

  #设置已选择的机构
  for el_org,idx in $("select.select_org_multi_for_vote")
    pre_item_orgs = $(el_org).data("orgs")
    org_ids = (vote_config_org.org_id for vote_config_org in pre_item_orgs)
    $(el_org).multipleSelect("setSelects",org_ids)

  $("#vote_config_with_org_form,#single_vote_config_with_org_form").on("submit", ->
    for el_org,idx in $("select.select_org_multi_for_vote")
      model_name = ""
      if $(this).attr("id") == "vote_config_with_org_form"
        model_name = "vote_config_with_org"

      if $(this).attr("id") == "single_vote_config_with_org_form"
        model_name = "single_vote_config_with_org"


      #先删除所有已选择的机构数据
      destroy_ids = $(el_org).data("orgs")
      for config_org,d_idx in destroy_ids when config_org.id != null
        el_id = $("<input type='hidden' name='#{model_name}[base_vote_config_orgs_attributes][#{d_idx}][id]' value='#{config_org.id}' />")
        el_destroy = $("<input type='hidden' name='#{model_name}[base_vote_config_orgs_attributes][#{d_idx}][_destroy]' value='true' />")
        $(this).append(el_id)
        $(this).append(el_destroy)

      #再保存选择的机构
      org_ids = $(el_org).multipleSelect("getSelects")
      for org_id,org_idx in org_ids
        el_config_org = $("<input type='hidden' name='#{model_name}[base_vote_config_orgs_attributes][#{org_idx + 999}][org_id]' value='#{org_id}' />")
        $(this).append(el_config_org)
  )
