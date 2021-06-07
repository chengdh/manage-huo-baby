# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.select_user_multi_in_message_form').multipleSelect(
    placeholder : "请选择用户",
    multiple: true,
    filter: true,
    selectAll: false
  )

  #设置已选择的机构
  for el,idx in $("#select_message_user")
    pre_users = $(el).data("users")
    user_ids = (user.id for user in pre_users)
    $(el).multipleSelect("setSelects",user_ids)

  $("#message_form").on("submit", ->
    for el_select_user,idx in $("#select_message_user")
      model_name = "message"
      field_name = "message_users"

      #先删除所有已选择的机构数据
      destroy_users = $(el_select_user).data("users")
      for d_user,d_idx in destroy_users
        el_id = $("<input type='hidden' name='#{model_name}[#{field_name}_attributes][#{d_idx}][user_id]' value='#{d_user.id}' />")
        el_destroy = $("<input type='hidden' name='#{model_name}[#{field_name}_attributes][#{d_idx}][_destroy]' value='true' />")
        $(this).append(el_id)
        $(this).append(el_destroy)

      #再保存选择的用户
      user_ids = $(el_select_user).multipleSelect("getSelects")
      for user_id,user_idx in user_ids
        el_user = $("<input type='hidden' name='#{model_name}[#{field_name}_attributes][#{user_idx}][user_id]' value='#{user_id}' />")
        $(this).append(el_user)
      if user_ids.length > 0
        $("#is_secure").val(1)
      else
        $("#is_secure").val(0)
  )
  $("#btn_show_message").fancybox(
    hideOnOverlayClick: false,
    onClosed: ->
      message = $("[data-message]").data("message")
      url = "/messages/#{message.id}/update_view_count"
      $.ajax(
        url: url,
        type: 'PUT',
      )
  )
  if $("#pop_message_show").length > 0
    $("#btn_show_message").trigger("click")
