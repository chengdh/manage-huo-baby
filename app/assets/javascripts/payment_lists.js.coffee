$ ->
  #生成代收货款支付清单
  #evt.data.is_cash 是否是现金支付
  #evt.data.bill_type_obj 要生成的运单类型
  gen_payment_list = (evt) ->
    params =
    "search[state_eq]": "refunded_confirmed",
    "search[goods_fee_gt]": 0,
    "search[completed_eq]": 0,
    "search[from_org_id_eq]" : $('#from_org_id').val()

    #运单列表显示的字段
    $.extend(params, $.show_or_hidden_fields_obj)

    #查询的运单类型
    if evt.data.bill_type_obj is undefined or not evt.data.bill_type_obj?
      $.extend(params, "search[type_in][]": ["ComputerBill", "HandBill","ReturnBill", "AutoCalculateComputerBill"])
    else
      $.extend(params,evt.data.bill_type_obj)

    if not (evt.data.is_cash is undefined) and evt.data.is_cash
      params["search[from_customer_id_is_null"] = "1"
      $('#from_org_id option').attr('disabled', true)
    else
      params["search[from_customer_id_is_not_null"] = "1"
      #二维码支付客户不再生成
      params["search[from_customer_is_qrcode_pay_eq"] = "0"
      params["search[from_customer_bank_id_eq]"] = $('#bank_id').val()
      $('#bank_id option').attr('disabled', true)

    $.get('/carrying_bills', params, null, 'script')

  $('#btn_generate_cash_payment_list').on("click",is_cash: true,gen_payment_list)

  $('#btn_generate_transfer_payment_list').on("click",is_cash: false,gen_payment_list)

  $('#btn_generate_outter_transit_cash_payment_list').on("click",
    is_cash: true,
    bill_type_obj :
      "search[type_in][]": ["TransitBill", "HandTransitBill"],
    gen_payment_list)

  $('#btn_generate_outter_transit_transfer_payment_list').on("click",
    is_cash: false,
    bill_type_obj :
      "search[type_in][]": ["TransitBill", "HandTransitBill"],
    gen_payment_list)

  $('#btn_generate_inner_transit_cash_payment_list').on("click",
    is_cash: true,
    bill_type_obj :
      "search[type_in][]": ["InnerTransitBill", "HandInnerTransitBill"],
    gen_payment_list)

  $('#btn_generate_inner_transit_transfer_payment_list').on("click",
    is_cash: false,
    bill_type_obj :
      "search[type_in][]": ["InnerTransitBill", "HandInnerTransitBill"],
    gen_payment_list)

  #同城快运-生成代收货款支付清单(现金)
  $('#btn_generate_local_town_cash_payment_list').on("click",
    is_cash: true,
    bill_type_obj :
      "search[type_in][]": ["LocalTownBill", "HandLocalTownBill","LocalTownReturnBill"],
    gen_payment_list)

  #同城快运-生成代收货款支付清单(转账)
  $('#btn_generate_local_town_transfer_payment_list').on("click",
    is_cash: false,
    bill_type_obj :
      "search[type_in][]": ["LocalTownBill", "HandLocalTownBill","LocalTownReturnBill"],
    gen_payment_list)
