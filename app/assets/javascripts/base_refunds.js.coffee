# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  #生成返款清单时,收款单位变化时,列出结算清单
  $('#btn_refound_refresh').click( ->
    $.get('/settlements',
      #是否显示选择列表
      "show_select": 1,
      "search[carrying_bills_from_org_id_eq]": $('[name="refound[to_org_id]"]').val(),
      "search[carrying_bills_to_org_id_eq]": $('[name="refound[from_org_id]"]').val(),
      "search[carrying_bills_type_in][]": ["ComputerBill", "HandBill", "ReturnBill", "AutoCalculateComputerBill"],
      "search[carrying_bills_state_eq]": "settlemented",
      "search[carrying_bills_completed_eq]": 0,
      "search[carrying_bills_goods_fee_or_carrying_bills_carrying_fee_gt]": 0
    null, 'script')
  )
  #外部中转返款清单生成
  $('#btn_outter_transit_refund_refresh').click( ->
    $.get('/outter_transit_settlements',
      #是否显示选择列表
      "show_select": 1,
      "search[carrying_bills_from_org_id_eq]": $('[name="outter_transit_refund[to_org_id]"]').val(),
      "search[carrying_bills_transit_org_id_or_carrying_bills_to_org_id_eq]": $('[name="outter_transit_refund[from_org_id]"]').val(),
      "search[carrying_bills_type_in][]": ["TransitBill", "HandTransitBill","OutterTransitReturnBill"],
      "search[carrying_bills_state_eq]": "settlemented",
      "search[carrying_bills_completed_eq]": 0,
      "search[carrying_bills_goods_fee_or_carrying_bills_carrying_fee_gt]": 0
    null, 'script')
  )
  #内部中转返款清单生成
  $('#btn_inner_transit_refund_refresh').click( ->
    $.get('/inner_transit_settlements',
      #是否显示选择列表
      "show_select": 1,
      "search[carrying_bills_from_org_id_eq]": $('[name="inner_transit_refund[to_org_id]"]').val(),
      "search[carrying_bills_transit_org_id_eq]": $('[name="inner_transit_refund[transit_org_id]"]').val(),
      "search[carrying_bills_to_org_id_eq]": $('[name="inner_transit_refund[from_org_id]"]').val(),
      "search[carrying_bills_type_in][]": ["InnerTransitBill", "HandInnerTransitBill","InnerTransitReturnBill"],
      "search[carrying_bills_state_eq]": "settlemented",
      "search[carrying_bills_completed_eq]": 0,
      "search[carrying_bills_goods_fee_or_carrying_bills_carrying_fee_gt]": 0
    null, 'script')
  )
  #同城快运-返款清单
  $('#btn_local_town_refund_refresh').click( ->
    $.get('/local_town_settlements',
      #是否显示选择列表
      "show_select": 1,
      "search[carrying_bills_from_org_id_eq]": $('[name="local_town_refund[to_org_id]"]').val(),
      "search[carrying_bills_to_org_id_eq]": $('[name="local_town_refund[from_org_id]"]').val(),
      "search[carrying_bills_type_in][]": ["LocalTownBill", "HandLocalTownBill", "LocalTownReturnBill"],
      "search[carrying_bills_state_eq]": "settlemented",
      "search[carrying_bills_completed_eq]": 0,
      "search[carrying_bills_goods_fee_or_carrying_bills_carrying_fee_gt]": 0
    null, 'script')
  )

  #全选结算清单
  $(document).on('click',"#check_all", ->
    for el in $('input[name^="selector"]')
      $(el).attr('checked', $('#check_all').attr('checked'))
    )

  #保存时判断是否选择了单据
  $(document).on("ajax:before","#refound_form,#inner_transit_refund_form,#outter_transit_refund_form,#local_town_refund_form", ->
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


  #绑定生成返款清单按钮
  func_ajax_complete = (form_id) ->
    return if $('#bills_table').length == 0
    sum_info = $('#bills_table').data('sum')
    return if sum_info is undefined or not sum_info?
    ids = $('#bills_table').data('ids')
    $('#refound_sum_goods_fee').html(sum_info.sum_goods_fee)
    $('#refound_sum_carrying_fee_th').html(sum_info.sum_carrying_fee_th)
    $('#refound_sum_insured_fee_th').html(sum_info.sum_insured_fee_th)
    $('#refound_sum_from_short_carrying_fee_th').html(sum_info.sum_from_short_carrying_fee_th)
    $('#refound_sum_to_short_carrying_fee_th').html(sum_info.sum_to_short_carrying_fee_th)
    $('#refound_sum_transit_carrying_fee').html(sum_info.sum_transit_carrying_fee_th)
    $('#refound_sum_transit_hand_fee').html(sum_info.sum_transit_hand_fee)
    $('#refound_sum_th_amount').html(sum_info.sum_th_amount)

    $(form_id).data('params',
      'bill_ids[]': ids
    )

  func_ajax_before = ->
    selected_bill_ids = []
    for el in $('input[name^="selector"]')
      selected_bill_ids.push($(el).val()) if $(el).attr('checked')

    if selected_bill_ids.length == 0
      $.notifyBar(
        html: "请选择要生成返款清单的结算清单!",
        delay: 3000,
        animationSpeed: "normal",
        cls: 'error'
      )
      return false

    params =
      "search[from_org_id_eq]": $('#to_org_id').val(),
      "search[to_org_id_or_transit_org_id_eq]": $('#from_org_id').val(),
      "search[state_eq]": "settlemented",
      "search[completed_eq]": 0,
      "search[goods_fee_or_carrying_fee_or_insured_fee_gt]": 0,
      "search[settlement_id_in][]": selected_bill_ids

    #判断是否是内部中转返款
    if $('#transit_org_id').length > 0
      params["search[transit_org_id_eq]"] = $('#transit_org_id').val()

    $.extend(params, $.show_or_hidden_fields_obj)
    $(this).data('params', params)

  $('#btn_generate_refound').on('ajax:before', func_ajax_before).on('ajax:complete', ->
    func_ajax_complete("#refound_form")
  )

  $('#btn_generate_outter_transit_refund').on('ajax:before', func_ajax_before).on('ajax:complete', ->
    func_ajax_complete("#outter_transit_refund_form")
  )

  $('#btn_generate_inner_transit_refund').on('ajax:before', func_ajax_before).on('ajax:complete', ->
    func_ajax_complete("#inner_transit_refund_form")
  )
  $('#btn_generate_local_town_refund').on('ajax:before', func_ajax_before).on('ajax:complete', ->
    func_ajax_complete("#local_town_refund_form")
  )
