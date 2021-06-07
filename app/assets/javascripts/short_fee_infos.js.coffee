$ ->
  #选择机构变化时,获取其下级机构
  $("#short_fee_info_form #from_org_id_or_to_org_id").on("change",->
    org_id = $(this).val()
    if org_id == ""
      return
    $.getJSON("/orgs.json",
    {
      "search[parent_id_eq]": org_id,
      "search[is_active_eq]": 1
    },
    (c_orgs)-> $("#short_fee_info_form #from_org_id_or_to_org_id").data("children",c_orgs)
    )
  )
  $('.short_fee_info_lines tr[data-bill]').livequery(->
    org_id = parseInt($('#from_org_id_or_to_org_id').val())
    bill_info = $(this).data('bill')
    if bill_info
      if bill_info.from_org_id != org_id and bill_info.to_org_id != org_id
        $(this).remove()
      if bill_info.from_org_id == org_id and (bill_info["from_short_fee_saved?"] or bill_info.from_short_carrying_fee == 0 or bill_info.from_short_fee_state == 'offed')
        $(this).remove()
      if bill_info.to_org_id == org_id and (bill_info["to_short_fee_saved?"] or bill_info.to_short_carrying_fee == 0 or bill_info.to_short_fee_state == 'offed')
        $(this).remove()
      $('#bills_table_body').trigger('tr_changed')
  )

  #生成短途运费报销清单时,绑定查询条件
  $('#btn_generate_from_short_fee_info,#btn_generate_to_short_fee_info,#btn_generate_from_short_fee_info_cash,#btn_generate_to_short_fee_info_cash').bind('ajax:before',->
    scope_param = {}
    ele_id = $(this).attr("id")
    p_org_id =  $("#short_fee_info_form #from_org_id_or_to_org_id").val()
    c_orgs = $("#short_fee_info_form #from_org_id_or_to_org_id").data("children")

    org_ids = []
    org_ids.push(p_org_id)
    if c_orgs
      org_ids.push(o.id) for o in c_orgs
    if ele_id == "btn_generate_from_short_fee_info" or ele_id == "btn_generate_from_short_fee_info_cash"
      scope_param = 
        "search[bills_with_from_short_carrying_fee][]": org_ids,
        "hide_fields": ".to_short_carrying_fee,.goods_fee"

      $('.fee_type').val('from')
    if ele_id == "btn_generate_to_short_fee_info" or ele_id == "btn_generate_to_short_fee_info_cash"
      scope_param =
        "search[bills_with_to_short_carrying_fee][]": org_ids,
        "hide_fields": ".from_short_carrying_fee,.goods_fee"
      $('.fee_type').val('to')

    params = {}
    if ele_id == "btn_generate_from_short_fee_info"
      params =
        #只报销提付、及货款扣支付方式的运单
        "search[pay_type_in][]": ['TH', 'KG'],
        "search[refound_bill_date_gte]": $('#refound_bill_date_gte').val(),
        "search[refound_bill_date_lte]": $('#refound_bill_date_lte').val(),
        "search[state_ni][]": ["billed", "loaded", "shipped", "reached", "returned", "distributed", "deliveried", "settlemented", "invalided", "canceled"],
        "search[type_in][]": ['ComputerBill', 'HandBill', 'ReturnBill', 'TransitBill', 'HandTransitBill','InnerTransitBill', 'HandInnerTransitBill', 'AutoCalculateComputerBill'],
        "without_paginate": true #不分页

    if ele_id == "btn_generate_to_short_fee_info"
      params =
        #只报销提付、及货款扣支付方式的运单
        "search[pay_type_in][]": ['TH'],
        "search[refound_bill_date_gte]": $('#refound_bill_date_gte').val(),
        "search[refound_bill_date_lte]": $('#refound_bill_date_lte').val(),
        "search[state_ni][]": ["billed", "loaded", "shipped", "reached", "returned", "distributed", "deliveried", "settlemented", "invalided", "canceled"],
        "search[type_in][]": ['ComputerBill', 'HandBill', 'ReturnBill', 'TransitBill', 'HandTransitBill','InnerTransitBill', 'HandInnerTransitBill', 'AutoCalculateComputerBill'],
        "without_paginate": true #不分页

    if ele_id == "btn_generate_from_short_fee_info_cash"
      params =
        #只报销现付、及回执付的运单
        "search[pay_type_in][]": ['CA', 'RE'],
        "search[settlement_bill_date_gte]": $('#refound_bill_date_gte').val(),
        "search[settlement_bill_date_lte]": $('#refound_bill_date_lte').val(),
        "search[state_ni][]": ["billed", "loaded", "shipped", "reached", "returned", "distributed", "deliveried", "invalided", "canceled"],
        "search[type_in][]": ['ComputerBill', 'HandBill', 'ReturnBill', 'TransitBill', 'HandTransitBill', 'AutoCalculateComputerBill'],
        "without_paginate": true #不分页

    if ele_id == "btn_generate_to_short_fee_info_cash"
      params =
        #只报销现付、及回执付的运单
        "search[pay_type_in][]": ['CA', 'RE','KG'],
        "search[settlement_bill_date_gte]": $('#refound_bill_date_gte').val(),
        "search[settlement_bill_date_lte]": $('#refound_bill_date_lte').val(),
        "search[state_ni][]": ["billed", "loaded", "shipped", "reached", "returned", "distributed", "deliveried", "invalided", "canceled"],
        "search[type_in][]": ['ComputerBill', 'HandBill', 'ReturnBill', 'TransitBill', 'HandTransitBill', 'AutoCalculateComputerBill'],
        "without_paginate": true #不分页

    #以下设定运单列表中的显示及隐藏字段,设定为css选择符
    $.extend(params, $.show_or_hidden_fields_obj, scope_param)
    $(this).data('params', params)
  ).bind('ajax:complete', ->
    if $('#bills_table').length == 0
      return

    sum_info = $('#bills_table').data('sum')
    ids = $('#bills_table').data('ids')
    $('#short_fee_info_form').data('params', {
      'bill_ids[]': ids
    })
  )
