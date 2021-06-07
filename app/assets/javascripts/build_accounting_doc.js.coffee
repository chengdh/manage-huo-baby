$ ->
  Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1

  class BuildAccountingSelector
    constructor: (@btn_build,@param_name) ->
      @selected_ids = []
      $('body').on("click",'.cbx_select_all_for_build_accounting_doc',@func_select_all)
      $('body').on("click",'.cbx_select_for_build_accounting_doc',@func_select_single)

    #全选事件
    func_select_all : =>
      set_all = $('.cbx_select_all_for_build_accounting_doc').attr('checked')
      #清空数组
      @selected_ids.length = 0
      if set_all
        $('.cbx_select_for_build_accounting_doc').attr('checked',true)
        @selected_ids.push($(line).val()) for line in $('.cbx_select_for_build_accounting_doc')
      else
        $('.cbx_select_for_build_accounting_doc').attr('checked',false)

      @change_build_btn_href()


      #单选事件
    func_select_single : (evt)=>
      cur_cbx = $(evt.target)
      selected = cur_cbx.attr('checked')
      selected_id = cur_cbx.val()
      if selected
        @selected_ids.push(selected_id) if !(selected_id in @selected_ids)
      else
        @selected_ids.remove(selected_id)

      @change_build_btn_href()

    #根据选择情况,改变生成凭证按钮的href
    change_build_btn_href : => 
      href = "#"
      @btn_build.hide()
      if @selected_ids.length > 0
        href = @btn_build.data('href')
        querystring = ("#{@param_name}=#{id}" for id in @selected_ids).join("&")
        href += "&#{querystring}"
        @btn_build.show()

      @btn_build.attr('href',href)

  #转账-代收货款支付清单
  new BuildAccountingSelector($(".btn_build_accounting_document_transfer_payment_list"),"search[payment_list_id_in][]") if $(".btn_build_accounting_document_transfer_payment_list").length
  new BuildAccountingSelector($(".btn_build_accounting_document_from_th"),"search[refound_id_in][]") if $(".btn_build_accounting_document_from_th").length


  new BuildAccountingSelector($(".btn_export_excel_for_kingdee_transfer_payment_list"),"search[payment_list_id_in][]") if $(".btn_export_excel_for_kingdee_transfer_payment_list").length
  #收款清单-导出金蝶数据接口
  new BuildAccountingSelector($(".btn_export_excel_for_kingdee_receive_refound"),"search[id_in][]") if $(".btn_export_excel_for_kingdee_receive_refound").length

