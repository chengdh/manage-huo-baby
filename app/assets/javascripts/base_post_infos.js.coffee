# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#tab_show_bill_list').click( ->
    $('#pay_info_list_wrap').hide()
    $('#table_wrap').show()
  )

  $('#tab_show_pay_info_list').click( ->
    $('#pay_info_list_wrap').show()
    $('#table_wrap').hide()
  )

  func_ajax_before = (options)->
    params =
      "search[from_org_id_eq]": $('#from_org_id').val(),
      "search[state_eq]": 'paid',
      "search[completed_eq]": 0,
      "search[from_customer_id_is_null]": 1

    #运单列表显示的字段
    $.extend(params, $.show_or_hidden_fields_obj)

    if options is undefined or not options?
      $.extend(params,
        "search[type_in][]": ["ComputerBill", "HandBill", "AutoCalculateComputerBill"])
    else
      $.extend(params,options)

    $(this).data('params', params)


  #生成外部中转结算清单
  $('#btn_generate_ot_post_info').on('ajax:before', -> 
    func_ajax_before.call(this,
      "search[type_in][]": ["TransitBill", "HandTransitBill"]
    )
  )

  #生成内部中转结算清单
  $('#btn_generate_inner_transit_post_info').on('ajax:before', -> 
    func_ajax_before.call(this,
      "search[type_in][]": ["InnerTransitBill", "HandInnerTransitBill"]
    )
  )
  #生成同城快运-客户提款结算清单
  $('#btn_generate_local_town_post_info').on('ajax:before', -> 
    func_ajax_before.call(this,
      "search[type_in][]": ["LocalTownBill", "HandLocalTownBill","LocalTownReturnBill"]
    )
  )

  $('#btn_generate_post_info').on('ajax:before', -> func_ajax_before.call(this))

  #绑定实领金额变化事件
  #绑定$.bill_selector的select:change事件,用于触发当选定单据发生变化时,重新计算金额
  func_re_cal_rest_fee = ->
    sum_info = $.bill_selector.sum_info
    $('#post_info_sum_goods_fee').html(sum_info.sum_goods_fee)
    $('#post_info_sum_k_carrying_fee').html(sum_info.sum_k_carrying_fee)
    $('#post_info_sum_k_hand_fee').html(sum_info.sum_k_hand_fee)
    $('#post_info_sum_k_insured_fee').html(sum_info.sum_k_insured_fee)
    $('#post_info_sum_k_from_short_carrying_fee').html(sum_info.sum_k_from_short_carrying_fee)
    $('#post_info_sum_k_to_short_carrying_fee').html(sum_info.sum_k_to_short_carrying_fee)
    $('#post_info_sum_transit_hand_fee').html(sum_info.sum_transit_hand_fee)
    #计算实际提款及余额
    $('#post_info_sum_act_pay_fee').html(sum_info.sum_act_pay_fee)

  $($.bill_selector).on('select:change', func_re_cal_rest_fee)
