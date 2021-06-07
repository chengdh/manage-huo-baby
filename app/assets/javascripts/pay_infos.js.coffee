$ ->
  func_ajax_before = (options)->
    selected_bill_ids = [];
    for el in $('input[name^="selector"]')
      selected_bill_ids.push($(el).val()) if $(el).attr('checked')

    if selected_bill_ids.length == 0
      $.notifyBar(
        html: "请选择要批量提款的代收货款支付清单!",
        delay: 3000,
        animationSpeed: "normal",
        cls: 'error'
      )
      return false

    params =
      "search[state_eq]": "payment_listed",
      "search[payment_list_id_in][]": selected_bill_ids

    #运单列表显示的字段
    $.extend(params, $.show_or_hidden_fields_obj)

    if options is undefined or not options?
      $.extend(params,
        "search[type_in][]": ["ComputerBill", "HandBill", "AutoCalculateComputerBill","ReturnBill"])
    else
      $.extend(params,options)

    $(this).data('params', params)

  func_ajax_complete = (form_id)->
    return if $('#bills_table').length == 0
    ids = $('#bills_table').data('ids')
    $(form_id).data('params','bill_ids[]': ids)

  #单张票据提款
  $(document).on('ajax:complete','.search_box_pay_info', -> func_ajax_complete("#transfer_pay_info_form"))


  #批量提款,银行转账界面,绑定生成批量提款清单按钮功能
  $('#btn_generate_transfer_pay_info').on('ajax:before', -> func_ajax_before.call(this)
  ).on('ajax:complete', -> func_ajax_complete("#transfer_pay_info_form"))

  #批量提款,银行转账界面,绑定生成批量提款清单按钮功能
  $('#btn_generate_outter_transit_transfer_pay_info').on('ajax:before', ->
    func_ajax_before.call(this,
        "search[type_in][]": ["TransitBill", "HandTransitBill"]
    )
  ).on('ajax:complete', -> func_ajax_complete("#outter_transit_transfer_pay_info_form"))

  #批量提款,银行转账界面,绑定生成批量提款清单按钮功能
  $('#btn_generate_inner_transit_transfer_pay_info').on('ajax:before', ->
    func_ajax_before.call(this,
        "search[type_in][]": ["InnerTransitBill", "HandInnerTransitBill"]
    )
  ).on('ajax:complete', -> func_ajax_complete("#inner_transit_transfer_pay_info_form"))

  #同城快运,银行转账界面,绑定生成批量提款清单按钮功能
  $('#btn_generate_local_town_transfer_pay_info').on('ajax:before', ->
    func_ajax_before.call(this,
        "search[type_in][]": ["LocalTownBill", "HandLocalTownBill","LocalTownReturnBill"]
    )
  ).on('ajax:complete', -> func_ajax_complete("#local_town_transfer_pay_info_form"))


  #保存转账清单,判断是否查询了相关的运单
  $(document).on("ajax:before","#transfer_pay_info_form,#inner_transit_transfer_pay_info_form,#outter_transit_transfer_pay_info_form,#local_town_transfer_pay_info_form", ->
    selected_bill_ids = $(this).data('params')
    if selected_bill_ids is undefined or selected_bill_ids['bill_ids[]'].length == 0
      $.notifyBar(
        html: "当前未选择任何运单!",
        delay: 3000,
        animationSpeed: "normal",
        cls: 'error'
      )
  )
  $(document).on("ajax:before","#inner_transit_cash_pay_info_form,#outter_transit_cash_pay_info_form,#local_town_cash_pay_info_form", ->
    bill_els = $('[data-bill]')
    bill_ids = []
    #中转提货相关费用
    #获取中转相关费用array
    get_transit_edit_fields_val  = (el_name) ->
      ret_val = []
      for el in $('[name^="' + el_name + '"]')
        ret_val.push($(el).val())

      return ret_val

    if bill_els.length == 0
      $.notifyBar(
        html: "未查找到任何运单,请先查询要处理的运单",
        delay: 3000,
        animationSpeed: "normal",
        cls: 'error'
      )
      return false
    else
      for el in bill_els
        bill = $(el).data('bill')
        bill_id = bill.id
        bill_ids.push(bill_id)

      $(this).data('params',
        "bill_ids[]": bill_ids,
        "transit_carrying_fee_edit[]": get_transit_edit_fields_val('transit_carrying_fee_edit'),
        "transit_hand_fee_edit[]": get_transit_edit_fields_val('transit_hand_fee_edit'),
        "transit_to_phone_edit[]": get_transit_edit_fields_val('transit_to_phone_edit'),
        "transit_bill_no_edit[]": get_transit_edit_fields_val('transit_bill_no_edit')
      )
      return true
  )

  #提交cash_pay_info_form时,处理bill_ids参数
  $(document).on("ajax:before","#cash_pay_info_form", ->
    bill_els = $('[data-bill]')
    bill_ids = []
    #中转提货相关费用
    #获取中转相关费用array
    get_transit_edit_fields_val  = (el_name) ->
      ret_val = []
      for el in $('[name^="' + el_name + '"]')
        ret_val.push($(el).val())

      return ret_val

    if bill_els.length == 0
      $.notifyBar(
        html: "未查找到任何运单,请先查询要处理的运单",
        delay: 3000,
        animationSpeed: "normal",
        cls: 'error'
      )
      return false
    else
      #判断account_name与运单发货人姓名是否一致
      account_name = $("#account_name").val()
      for el in bill_els
        bill = $(el).data('bill')
        if not $(this).hasClass("unlimited_account_name") and bill.from_customer_name != account_name
          checked = false
          $.notifyBar(
            html: "转账户名与运单不符,运单号:(#{bill.bill_no})",
            delay: 3000,
            animationSpeed: "normal",
            cls: 'error'
          )
          return false

        bill_id = bill.id
        bill_ids.push(bill_id)

    $(this).data('params',
      "bill_ids[]": bill_ids,
      "transit_carrying_fee_edit[]": get_transit_edit_fields_val('transit_carrying_fee_edit'),
      "transit_hand_fee_edit[]": get_transit_edit_fields_val('transit_hand_fee_edit'),
      "transit_to_phone_edit[]": get_transit_edit_fields_val('transit_to_phone_edit'),
      "transit_bill_no_edit[]": get_transit_edit_fields_val('transit_bill_no_edit')
    )
    return true
  )
