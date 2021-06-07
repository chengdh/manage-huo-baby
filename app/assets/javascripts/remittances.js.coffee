$ ->
  $('#btn_validate_remittance').on('click',->
    result = prompt("录入实际核对金额:",0)
    validate_fee = parseFloat(result)
    if isNaN(validate_fee)
      return false
    else
      url = $(this).attr('href')
      new_url = $.update_query_string_parameter(url,"update_attrs[validate_fee]",validate_fee)
      $(this).attr('href',new_url)
      return true
  )
  #金额变化时自动计算
  $("#remittance_form").on("change", ->
    should_fee = parseFloat($("#remittance_should_fee").val())
    inner_transit_refund_should_fee = parseFloat($("#remittance_inner_transit_refund_should_fee").val())
    act_fee = parseFloat($("#remittance_act_fee").val())
    pos_fee = parseFloat($("#remittance_pos_fee").val())
    quick_fee = parseFloat($("#remittance_quick_fee").val())
    other_fee = parseFloat($("#remittance_other_fee").val())
    total_fee = act_fee + pos_fee + quick_fee + other_fee
    diff_fee = should_fee + inner_transit_refund_should_fee - total_fee

    $(".total_fee").html(total_fee)
    $(".diff_fee").html(diff_fee)
  )
  $("#btn_submit_remittance_form").one('click',->
    $("#remittance_form").trigger("submit")
  )
