 $ ->
  calculate_carrying_bill = (evt)->
    target_el = $(evt.target)
    #计算运费合计
    carrying_fee = parseFloat($('#carrying_fee').val())
    #运费大于指定金额时才产生保险费
    orgs = $('#global_data').data('orgs')

    from_org_id = parseInt($('#from_org_id').val())
    to_org_id = parseInt($('#to_org_id').val())
    to_org = null;
    from_org = null;
    pay_type = $('#pay_type').val()
    for org in orgs
      if org["id"] == to_org_id
        to_org = org
      if org["id"] == from_org_id
        from_org = org

    if to_org != null and (!! $('#insured_fee').attr('data-carrying_fee_gte_on_insured_fee'))
      #得到org数组,判断
      carrying_fee_set_special = null
      carrying_fee_set_special = to_org["carrying_fee_gte_on_insured_fee"]
      fixed_insured_fee_special = to_org["fixed_insured_fee"]
      carrying_fee_gte = parseFloat($('#insured_fee').data('carrying_fee_gte_on_insured_fee'))
      config_insured_fee = parseFloat($('#insured_fee').data('config_insured_fee'))

      #判断组织机构中是否设置了保险费
      if carrying_fee_set_special
        carrying_fee_gte = parseFloat(carrying_fee_set_special)
        config_insured_fee =  parseFloat(fixed_insured_fee_special)

      #FIXME 修改运费值会触发change事件,该代码会执行两次
      if carrying_fee < carrying_fee_gte
        $('#insured_fee').val(0)
      else
        $('#insured_fee').val(config_insured_fee)

    #20140611 根据org中的设置自动生成到货短途
    if to_org != null and to_org.auto_generate_to_short_carrying_fee and (to_org.agtscf_rate > 0 || to_org.fixed_to_short_carrying_fee > 0)
      fee = 0;
      #先计算固定到货短途
      if  to_org.fixed_to_short_carrying_fee > 0
        fee = to_org.fixed_to_short_carrying_fee

      #按比例计算到货短途
      if to_org.agtscf_rate > 0
        fee = Math.round(carrying_fee * to_org.agtscf_rate)

      old_fee = Math.round(parseFloat($('#to_short_carrying_fee').val()))
      if $(target_el).attr("id") == "carrying_fee" or   $(target_el).attr("id") == "adjust_carrying_fee" or old_fee < fee
        $('#to_short_carrying_fee').val(fee)
        $(".to_short_carrying_fee_alert").show().delay(5000).fadeOut()


      #内部中转及外部中转不生成到货短途
      if $(this).hasClass('transit_bill') \
      or $(this).hasClass('hand_transit_bill')  \
      or $(this).hasClass('local_town_bill') \
      or $(this).hasClass('local_town_return_bill') \
      or $(this).hasClass('hand_local_town_bill')
        $('#to_short_carrying_fee').val(0)
        $('#insured_fee').val(0)
        $('#manage_fee').val(0)

      if $(this).hasClass('inner_transit_bill')  \
      or $(this).hasClass('hand_inner_transit_bill')
        $('#to_short_carrying_fee').val(0)
        $('#insured_fee').val(0)

    #20170301 根据org中的设置自动生成发货短途
    if  from_org != null and from_org.auto_generate_from_short_carrying_fee and (from_org.agfscf_rate > 0 || from_org.fixed_from_short_carrying_fee > 0)
      fee = 0;
      #先计算固定到货短途
      if  from_org.fixed_from_short_carrying_fee > 0
        fee = from_org.fixed_from_short_carrying_fee

      #按比例计算到货短途
      if from_org.agfscf_rate > 0
        fee = Math.round(carrying_fee * from_org.agfscf_rate)

      old_fee = Math.round(parseFloat($('#from_short_carrying_fee').val()))
      if $(target_el).attr("id") == "carrying_fee" or   $(target_el).attr("id") == "adjust_carrying_fee" or old_fee < fee
        $('#from_short_carrying_fee').val(fee)
        $(".from_short_carrying_fee_alert").show().delay(5000).fadeOut()


      #内部中转及外部中转不生成到货短途
      if $(this).hasClass('transit_bill') \
      or $(this).hasClass('hand_transit_bill')  \
      or $(this).hasClass('local_town_bill') \
      or $(this).hasClass('local_town_return_bill') \
      or $(this).hasClass('hand_local_town_bill') \
      or $(this).hasClass('inner_transit_bill')  \
      or $(this).hasClass('hand_inner_transit_bill')
        $('#from_short_carrying_fee').val(0)


    #NOTE 2015-11-08 根据short_fee_config设置生成到货短途费
    short_fee_configs = $("#global_data").data("short_fee_configs")

    if pay_type == 'TH' and from_org !=null and to_org != null
      cal_short_fee = 0
      cal_from_short_fee = 0
      for config in short_fee_configs
        if config.from_org_id == from_org_id and config.to_org_id == to_org_id
          apply_cal = false
          #运费小于等于设定的值
          if config.operator == 'lte' and carrying_fee <= config.carrying_fee
            apply_cal = true

          #运费小于设定的值
          if config.operator == 'lt' and carrying_fee < config.carrying_fee
            apply_cal = true

          #运费大于等于设定的值
          if config.operator == 'gte' and carrying_fee >= config.carrying_fee
            apply_cal = true


          #运费大于设定的值
          if config.operator == 'gt' and carrying_fee > config.carrying_fee
            apply_cal = true

          if apply_cal
            cal_short_fee = Math.round(carrying_fee*config.short_fee_rate)
            if config.fixed_short_fee > 0
              cal_short_fee = Math.round(config.fixed_short_fee)

            cal_from_short_fee = Math.round(carrying_fee*config.from_short_fee_rate)
            if config.fixed_from_short_fee > 0
              cal_from_short_fee = Math.round(config.fixed_from_short_fee)

          $('#to_short_carrying_fee').val(cal_short_fee)
          $('#from_short_carrying_fee').val(cal_from_short_fee)
          $(".to_short_carrying_fee_alert").show().delay(5000).fadeOut()
          $(".from_short_carrying_fee_alert").show().delay(5000).fadeOut()

          #内部中转及外部中转不生成到货短途
          if $(this).hasClass('transit_bill') or $(this).hasClass('hand_transit_bill') or $(this).hasClass('inner_transit_bill') or $(this).hasClass('hand_inner_transit_bill') or $(this).hasClass('local_town_bill')
            $('#to_short_carrying_fee').val(0)
            $('#from_short_carrying_fee').val(0)

    insured_fee = parseFloat($('#insured_fee').val())
    from_short_carrying_fee = parseFloat($('#from_short_carrying_fee').val())
    to_short_carrying_fee = parseFloat($('#to_short_carrying_fee').val())

    #2013-10-14 管理费
    manage_fee = 0
    if($('#manage_fee').length > 0)
      manage_fee = parseFloat($('#manage_fee').val())

    sum_carrying_fee = carrying_fee + from_short_carrying_fee + to_short_carrying_fee + manage_fee
    $('#sum_carrying_fee').text(sum_carrying_fee)
    #计算总金额合计
    goods_fee = parseFloat($('#goods_fee').val())
    sum_fee = sum_carrying_fee



  $(document).on("change",'form.carrying_bill', calculate_carrying_bill)

  #运单录入界面,金额只允许录入整数
  #$('.only_integer').numeric(false)

  #运单修改时,判断权限
  $('form.carrying_bill_edit,form.update_goods_fee,form.update_carrying_fee,form.update_all').livequery( ->
    $('#carrying_bill_form :input').attr('readonly', true)
    $('#carrying_bill_form :checkbox').attr('disabled', true)
    $('#carrying_bill_form select option').attr('disabled', true)
  )

  #修改货款是无条件的,有权限即可修改,与运单权限无关
  $('form.update_goods_fee').livequery( ->
    $('#goods_fee').attr('readonly', false)
    # $('#from_customer_name').attr('readonly', false)
    # $('#from_customer_phone').attr('readonly', false)
    # $('#from_customer_mobile').attr('readonly', false)
    # $('#to_customer_name').attr('readonly', false)
    # $('#to_customer_phone').attr('readonly', false)
    # $('#to_customer_mobile').attr('readonly', false)
    $('#note').attr('readonly', false)
    $('#goods_info').attr('readonly', false)
    $('#package').attr('readonly', false)

    # $('#pay_type').attr('disabled', false)
    # $('#pay_type option').attr('disabled', false)
  )

  $('form.update_carrying_fee').livequery( ->
    # $('#carrying_fee').attr('readonly', false)
    # $('#from_short_carrying_fee').attr('readonly', false)
    # $('#to_short_carrying_fee').attr('readonly', false)
    # $('#pay_type').attr('disabled', false)
    # $('#pay_type option').attr('disabled', false)
    $('#note').attr('readonly', false)
    $('#goods_info').attr('readonly', false)
    $('#package').attr('readonly', false)


    #判断是否内部中转运单
    if $(this).hasClass('inner_transit_bill') or $(this).hasClass('hand_inner_transit_bill')
      $('#carrying_fee').attr('readonly', true)
      $('.carrying_fee_1st').attr('readonly', false)
      $('.carrying_fee_2st').attr('readonly', false)
  )

  $('form.update_all').livequery( ->
    $('#carrying_bill_form :input').attr('readonly', false)
    $('#carrying_bill_form :checkbox').attr('disabled', false)
    $('#carrying_bill_form select option').attr('disabled', false)
    $('#insured_fee').attr('readonly', true)
    $('#manage_fee').attr('readonly', true)
    $('.bill_date').attr('readonly',true)

    if $(this).hasClass('inner_transit_bill') or $(this).hasClass('hand_inner_transit_bill')
      $('#carrying_fee').attr('readonly', true)
      $('.carrying_fee_1st').attr('readonly', false)
      $('.carrying_fee_2st').attr('readonly', false)
  )

  #根据不同的运单录入界面,隐藏部分字段
  $('form.computer_bill,form.auto_calculate_computer_bill,form.ton_volume_bill,form.inner_transit_bill,form.local_town_bill').livequery( ->
    $('.bill_no').attr('readonly', true)
    $('.goods_no').attr('readonly', true)
    $('.bill_date').attr('readonly',true)
    if $(this).hasClass('edit_bill_date')
      $('.bill_date').addClass('datepicker')
    else
      $('.bill_date').removeClass('datepicker')
  )

  $('form.hand_bill,form.branch_bill,form.hand_inner_transit_bill,form.hand_local_town_bill').livequery( ->
    $('.bill_no').attr('readonly', false)
    $('.goods_no').attr('readonly', false)
    $('.bill_date').attr('readonly',true)
    $('.bill_date').removeClass('datepicker')
    $('.goods_num').attr('readonly', true)

  )

  $('form.transit_bill').livequery( ->
    $('.bill_no').attr('readonly', true)
    $('.goods_no').attr('readonly', true)
    $('.bill_date').attr('readonly',true)
    if $(this).hasClass('edit_bill_date')
      $('.bill_date').addClass('datepicker')
    else
      $('.bill_date').removeClass('datepicker')
  )

  $('form.hand_transit_bill').livequery( ->
    $('.bill_no').attr('readonly', false)
    $('.goods_no').attr('readonly', false)
    $('.bill_date').removeClass('datepicker')
    $('.goods_num').attr('readonly', true)
  )

  $('form.return_bill,form.local_town_return_bill,form.outter_transit_return_bill,form.inner_transit_return_bill').livequery( ->
    $(this).find('input').attr('readonly', true)
    $(this).find('select option').attr('disabled', true)

    $('#from_customer_name').attr('readonly', false)
    $('#to_customer_name').attr('readonly', false)
    $('#note').attr('readonly', false)

    $('.bill_date').attr('readonly',true)
    if $(this).hasClass('edit_bill_date')
      $('.bill_date').addClass('datepicker')
    else
      $('.bill_date').removeClass('datepicker')
  )

  #运单修改时,可修改货号
  # $('form.carrying_bill_edit').livequery( ->
  #   $('.goods_no').attr('readonly', false)
  # )

  #内部中转运单,前段运费和后段运费发生变化时,重新计算总运费
  #20170501 不再计算
  $(document).on("change","form.inner_transit_bill,form.hand_inner_transit_bill", ->
    fee_1st = parseFloat($('.carrying_fee_1st').val())
    fee_2st = parseFloat($('.carrying_fee_2st').val())
    carrying_fee = fee_1st + fee_2st
    $('#carrying_fee').val(carrying_fee)
  )

  #手工运单,自动解析日期和数量
  func_parse_bill_date = ->
    the_goods_no = $(this).val()
    tmp_bill_date = '20' + /^\d{6}/.exec(the_goods_no)
    changed_bill_date = tmp_bill_date.substr(0, 4) + "-" + tmp_bill_date.substr(4, 2) + "-" + tmp_bill_date.substr(6, 2)
    bill_date = $('.bill_date').val()
    goods_num = /\d+$/.exec(the_goods_no)
    if $(this).parents('form.carrying_bill').hasClass('edit_bill_date')
      $('.bill_date').val(changed_bill_date)
      $('.goods_num').val(goods_num)
    else if changed_bill_date == bill_date
      $('.goods_num').val(goods_num)
    else
      $.notifyBar(
        html: "运单日期不正确,您无权录入其他日期的票据!",
        delay: 3000,
        animationSpeed: "normal",
        cls: 'error'
      )
      $(this).val(bill_date.substr(2, 4) + bill_date.substr(6, 8) + bill_date.substr(9))
      $('.goods_num').val(1)


  $('#hand_bill_goods_no,#branch_bill_goods_no,#hand_transit_bill_goods_no,#hand_inner_transit_bill_goods_no,#hand_local_town_bill_goods_no').live('change',func_parse_bill_date)

  #货物数量变化,更新货号
  $("form.carrying_bill_edit .goods_num").live("change", ->
    goods_num = parseFloat($(this).val())
    goods_no = $("form.carrying_bill_edit .goods_no").val()
    new_goods_no = goods_no.replace( /\d+$/,goods_num)
    $("form.carrying_bill_edit .goods_no").val(new_goods_no)

  )
  #修改运单日期 对应货号变化
  func_parse_bill_goods_no = ->
    tmp = $(".bill_date").val().split("-")
    bill_date= tmp[0].substring(2) + tmp[1].substring(0) + tmp[2].substring(0,2)
    old_goods_no = $(".goods_no").val()
    new_goods_no = old_goods_no.replace(old_goods_no.substring(0,6),bill_date)
    $(".goods_no").val(new_goods_no)

  $("form.carrying_bill .bill_date").live("change",func_parse_bill_goods_no)

  #发货人姓名变化,从imported_customers中查询数据
  query_imported_customer = (evt)->
    el = evt.currentTarget
    if !!!$(el).val()
      return false
    el_customer_name = null
    el_customer_mobile = null
    el_customer_phone = null
    el_imported_customer = null
    el_next_focus = null
    el_btn_find_customer = null
    el_customer_detail = null
    el_org_id = null
    #清空原有数据
    if $(el).attr('id') == 'from_customer_mobile'
      el_customer_name = $('#from_customer_name')
      el_customer_mobile = $('#from_customer_mobile')
      el_customer_phone = $('#from_customer_phone')
      el_imported_customer = $('#imported_from_customer_id')
      el_next_focus = $('#to_customer_name')
      el_btn_find_customer = $('#btn_find_from_customer')
      el_customer_detail = $('.from_customer_detail')
      el_org_id = $("#from_org_id")

    if $(el).attr('id') == 'to_customer_mobile'
      el_customer_name = $('#to_customer_name')
      el_customer_mobile = $('#to_customer_mobile')
      el_customer_phone = $('#to_customer_phone')
      el_imported_customer = $('#imported_to_customer_id')
      el_org_id = $("#to_org_id")
      el_next_focus = $('#pay_type')
      el_btn_find_customer = $('#btn_find_to_customer')
      el_customer_detail = $('.to_customer_detail')

    $(el_imported_customer).val(null)
    $(el_customer_detail).html("")

    params =
      'search[mobile_or_mobile_2_or_mobile_3_or_mobile_4_or_mobile_5_eq]' : $(el).val(),
      'search[org_id_eq]'  : $(el_org_id).val()

    $.ajax(
      url : "/branch_customers/query_for_bill_input",
      data: params,
      dataType : 'json'
    ).then((customer)->
      if customer == null
        return
      $(el_customer_name).val(customer.name)
      # $(el_customer_mobile).val(customer.mobile)
      $(el_customer_phone).val(customer.phone)
      $(el_imported_customer).val(customer.id)
      $(el_customer_detail).html(customer.address_desc)

      $(el_next_focus).focus()
      
      # customers_table = "<div><table class='table'><thead><tr><th>姓名</th><th>手机</th><th>地址</th><th>选择</th></thead><tbody class='customers_table'></tbody></table></div>"
      # customer_tr="<tr class='popover_customer_tr' data-customer_id='{id}'><td>{name}</td><td>{mobile}</td><td>{address}</td><td><button class='btn-select-customer sexybutton sexysimple sexyblue'> > </button></td></tr>"
      # content_el = $(customers_table)
      #
      # tr_el = $(nano(customer_tr,customer))
      # content_el.find('.customers_table').append(tr_el)
      #
      # $(el_btn_find_customer).webuiPopover('destroy').webuiPopover(
      #   placement : 'bottom',
      #   title : '请选择客户',
      #   closeable : true,
      #   content : content_el.html()
      # ).webuiPopover('show')
      #
      # $('tr.popover_customer_tr').on('dblclick',(evt)->
      #   tr_el = evt.currentTarget
      #   customer_id = $(tr_el).data('customer_id')
      #   selected_customer = customer
      #   $(el_customer_name).val(selected_customer.name)
      #   $(el_customer_mobile).val(selected_customer.mobile)
      #   $(el_customer_phone).val(selected_customer.phone)
      #   $(el_imported_customer).val(selected_customer.id)
      #   $(el_customer_detail).html(selected_customer.address_desc)
      #
      #   $(el_btn_find_customer).webuiPopover('destroy')
      #   $(el_next_focus).focus()
      # )
      #
      # $('.btn-select-customer').on('click', -> $(this).parents('tr').trigger('dblclick'))
      #
      # $('.btn-select-customer:first').focus()
    )
    return true

  #$(document).on('change','#from_customer_mobile',query_imported_customer)
  $(document).on('change','#to_customer_mobile',query_imported_customer)

  #外部中转票据不显示发货及到货短途录入
  #$("form.transit_bill #from_short_carrying_fee,form.hand_transit_bill #from_short_carrying_fee").livequery( ->
  #  $(this).parents('tr').hide()
  #)

  #未提货报表,处理各种票据列表底色
  $('.rpt_no_delivery tr.white-bill,table.show-color-tr tr.white-bill').livequery( ->
    $(this).css(
      backgroundColor: 'white',
      color: '#000'
    )
  )

  $('.rpt_no_delivery tr.blue-bill,table.show-color-tr tr.blue-bill').livequery( ->
    $(this).css(
      backgroundColor: 'blue',
      color: '#fff'
    )
    $(this).find("a").css(
      color: '#fff'
    )
  )
  $('.rpt_no_delivery tr.green-bill,table.show-color-tr tr.green-bill').livequery( ->
    $(this).css(
      backgroundColor: 'green',
      color: '#fff'
    )

    $(this).find("a").css(
      color: '#fff'
    )
  )
  $('.rpt_no_delivery tr.yellow-bill,table.show-color-tr tr.yellow-bill').livequery( ->
    $(this).css(
      backgroundColor: 'yellow'
    )
  )

  $('.rpt_no_delivery tr.red-bill,table.show-color-tr tr.red-bill').livequery( ->
    $(this).css(
      backgroundColor: 'red',
      color: '#fff'
    )

    $(this).find("a").css(
      color: '#fff'
    )
  )
  $('.rpt_no_delivery tr.black-bill,table.show-color-tr tr.black-bill').livequery( ->
    $(this).css(
      backgroundColor: 'black',
      color: '#fff'
    )
    $(this).find("a").css(
      color: '#fff'
    )
  )


  func_check_org = ->
    #根据选择的机构,添加inputs
    to_org_ids = $('#select_to_org_ids_in_rpt_turnover').multipleSelect("getSelects")
    $('.input_to_org_id').remove()
    $('#form_search_rpt_turnover').append($("<input type='hidden' class='input_to_org_id'  name='search[to_org_id_in][]' value='#{org_id}'/>")) for org_id in to_org_ids

  # $('#select_to_org_ids_in_rpt_turnover').multipleSelect(
  #   placeholder : "请选择到货地",
  #   multiple: true,
  #   selectAll: false,
  #   onClick: func_check_org
  # )
