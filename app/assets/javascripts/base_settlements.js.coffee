# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  func_ajax_complete = (form_id)->
    return if not $('#bills_table')?

    sum_info = $('#bills_table').data('sum')

    return if sum_info is undefined or not sum_info?

    ids = $('#bills_table').data('ids')
    $('#settlement_sum_carrying_fee_th').html(sum_info.sum_carrying_fee_th)
    $('#settlement_sum_goods_fee').html(sum_info.sum_goods_fee)
    $('#settlement_sum_insured_fee_th').html(sum_info.sum_insured_fee_th)
    $('#settlement_sum_manage_fee_th').html(sum_info.sum_manage_fee_th)
    $('#settlement_sum_from_short_carryig_fee_th').html(sum_info.sum_from_short_carrying_fee_th)
    $('#settlement_sum_to_short_carryig_fee_th').html(sum_info.sum_to_short_carrying_fee_th)
    $('#settlement_sum_goods_fee').html(sum_info.sum_goods_fee)
    $('#settlement_sum_transit_carrying_fee').html(sum_info.sum_transit_carrying_fee)
    $('#settlement_sum_transit_hand_fee').html(sum_info.sum_transit_hand_fee)
    $('#settlement_sum_th_amount').html(sum_info.sum_th_amount)
    $(form_id).data('params', 'bill_ids[]': ids)

  #保存时判断是否选择了单据
  $(document).on("ajax:before","#settlement_form,#inner_transit_settlement_form,#outter_transit_settlement_form", ->
    selected_bill_ids = $(this).data('params')
    if selected_bill_ids is undefined or selected_bill_ids['bill_ids[]'].length == 0
      $.notifyBar(
        html: "当前未选择任何运单!",
        delay: 3000,
        animationSpeed: "normal",
        cls: 'error'
      )
      return false
  )

  #普通结算员交款清单
  $('#btn_generate_settlement').on('ajax:before', ->
    params =
      "search[to_org_id_eq]": $('#to_org_id').val(),
      "search[state_eq]": 'deliveried',
      "search[completed_eq]": 0,
      "search[type_in][]": ['ComputerBill', 'HandBill', 'ReturnBill',  'AutoCalculateComputerBill']

    $.extend(params, $.show_or_hidden_fields_obj)
    $(this).data('params', params)
  ).on('ajax:complete', -> func_ajax_complete("#settlement_form"))

  #同城快运-结算员交款清单
  $('#btn_generate_local_town_settlement').on('ajax:before', ->
    params =
      "search[to_org_id_eq]": $('#to_org_id').val(),
      "search[state_eq]": 'deliveried',
      "search[completed_eq]": 0,
      "search[type_in][]": ['LocalTownBill', 'HandLocalTownBill', 'LocalTownReturnBill']

    $.extend(params, $.show_or_hidden_fields_obj)
    $(this).data('params', params)
  ).on('ajax:complete', -> func_ajax_complete("#local_town_settlement_form"))


  #外部中转结算员交款清单
  $('#btn_generate_outter_transit_settlement').on('ajax:before', ->
    params =
      "search[transit_org_id_or_to_org_id_eq]": $('#to_org_id').val(),
      "search[state_eq]": 'deliveried',
      "search[completed_eq]": 0,
      "search[type_in][]": ['TransitBill', 'HandTransitBill','OutterTransitReturnBill']

    $.extend(params, $.show_or_hidden_fields_obj)
    $(this).data('params', params)
  ).on('ajax:complete', -> func_ajax_complete("#outter_transit_settlement_form"))

  #内部结算员交款清单
  $('#btn_generate_inner_transit_settlement').on('ajax:before', ->
    params =
      "search[to_org_id_eq]": $('#to_org_id').val(),
      "search[state_eq]": 'deliveried',
      "search[completed_eq]": 0,
      "search[type_in][]": ['InnerTransitBill', 'HandInnerTransitBill','InnerTransitReturnBill']

    $.extend(params, $.show_or_hidden_fields_obj)
    $(this).data('params', params)
  ).on('ajax:complete', -> func_ajax_complete("#inner_transit_settlement_form"))
