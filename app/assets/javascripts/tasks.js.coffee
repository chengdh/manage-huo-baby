# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $(".btn_save_task").one("click", ->
    $("#task_form").submit()
  )

  $(".select_user_multi_for_search").livequery(->
    $(this).multipleSelect(
      placeholder : "请选择用户",
      multiple: true,
      filter: true,
      selectAll: false
    )
  )

  tinymce.init({
    selector: 'textarea.tinymce',
    height: 200,
    language: 'zh_CN',
    plugins: [
      'advlist autolink lists link image charmap print preview anchor',
      'searchreplace visualblocks code fullscreen',
      'insertdatetime media table contextmenu paste code'
    ],
    toolbar: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image',
    file_browser_callback_types: 'image',
    file_picker_callback: (callback, value, meta)->
      if meta.filetype == 'image'
        $('#upload_image_in_task_form').trigger('click')
        $('#upload_image_in_task_form').on('change', ->
          file = this.files[0];
          reader = new FileReader();
          reader.onload = (e)-> callback(e.target.result, {alt: ''})
          reader.readAsDataURL(file);
        )
  })

  $('.select_user_multi').multipleSelect(
    placeholder : "请选择用户",
    multiple: true,
    filter: true,
    selectAll: false
  )

  #设置已选择的机构
  for el,idx in $("#select_task_user,#select_task_par_user")
    pre_users = $(el).data("users")
    user_ids = (user.id for user in pre_users)
    $(el).multipleSelect("setSelects",user_ids)

  $("#task_form").on("submit", ->
    for el_select_user,idx in $("#select_task_user,#select_task_par_user")
      model_name = "task"
      field_name = "task_users"
      if $(el_select_user).prop("id") == "select_task_user"
        field_name = "task_users"
      else
        field_name = "task_participation_users"

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
  )
