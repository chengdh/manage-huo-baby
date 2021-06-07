#多选控件
$ ->
  Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1

  class MultiSelector
    constructor: (@change_callback) ->
      @selected_ids = []
      $('body').on("click",'.cbx_select_all',@func_select_all)
      $('body').on("click",'.cbx_select_single',@func_select_single)

    #全选事件
    func_select_all : =>
      set_all = $('.cbx_select_all').attr('checked')
      #清空数组
      @selected_ids.length = 0
      if set_all
        $('.cbx_select_single').attr('checked',true)
        @selected_ids.push($(line).val()) for line in $('.cbx_select_single')
      else
        $('.cbx_select_single').attr('checked',false)

      if @change_callback
        @change_callback.call(@)


    #单选事件
    func_select_single : (evt)=>
      cur_cbx = $(evt.target)
      selected = cur_cbx.attr('checked')
      selected_id = cur_cbx.val()
      if selected
        @selected_ids.push(selected_id) if !(selected_id in @selected_ids)
      else
        @selected_ids.remove(selected_id)

      if @change_callback
        @change_callback.call(@)

  #客户提款结算清单生成银行批量转账文本
  post_info_callback = ->
    href = "#"
    $('.btn_batch_export_with_bank').hide()
    $('.btn_batch_transfer').hide()

    for el in $('.btn_batch_export_with_bank')
      if @selected_ids.length > 0
        href = $(el).data('href')
        querystring = ("ids[]=#{id}" for id in @selected_ids).join("&")
        href += "&#{querystring}"
        $(el).show()
        $(el).attr('href',href)

    for el in $('.btn_batch_transfer')
      if @selected_ids.length > 0
        href = $(el).data('href')
        querystring = ("ids[]=#{id}" for id in @selected_ids).join("&")
        href += "&#{querystring}"
        $(el).show()
        $(el).attr('href',href)


  new MultiSelector(post_info_callback)
