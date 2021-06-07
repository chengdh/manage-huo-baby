# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  #生成返程货-代收货款支付清单(转账)
  gen_payment_list = (evt) ->
    params =
      "search[state_eq]": "refunded_confirmed",
      "search[goods_fee_gt]": 0,
      "search[completed_eq]": 0,
      "search[type_in][]": ["InnerTransitBill", "HandInnerTransitBill"],
      "search[transit_org_id_eq]" : $('#summary_org_id').val()

    #运单列表显示的字段
    $.extend(params, $.show_or_hidden_fields_obj)

    params["search[from_customer_id_is_not_null"] = "1"
    params["search[from_customer_bank_id_eq]"] = $('#bank_id').val()

    $('#bank_id option').attr('disabled', true)

    $.get('/carrying_bills', params, null, 'script')

  $('#btn_generate_summary_org_inner_transit_transfer_payment_list').on("click",gen_payment_list)
