$ ->
  $(".datepicker").pickadate(
    formatSubmit: 'yyyy-mm-dd',
    hiddenName: true
  )
  $("#btn_query_submit").on("click", ->
    check = true
    if $("#search_text").val() == ""
      $("#search_text").notify("请输入运单号!","error")
      check = false

    if $("#search_from_customer_code").length > 0 and $("#search_from_customer_code").val() == ""
      $("#search_from_customer_code").notify("请输入客户卡号!","error")
      check = false

    if $("#search_from_customer_name").length > 0 and $("#search_from_customer_name").val() == ""
      $("#search_from_customer_name").notify("请输入客户姓名!","error")
      check = false

    if check
      $("#search_service_form").submit()

  )
  #按照客户卡号查询时,选择状态
  $("#select_search_service_bill_state").on("change", ->
    states = []
    if $(this).val() == "no_deliveried"
      states = ["billed","loaded","shipped","distributed"]
    if $(this).val() == "deliveried_no_paid"
      states = ["deliveried","settlemented","refunded","refunded_confirmed","payment_listed"]
    if $(this).val() == "paid"
      states = ["paid","posted"]

    $(".input_state_for_search_service").remove()

    $("#search_service_form").append($("<input type='hidden' class='input_state_for_search_service' name='search[state_in][]' value='#{s}' />")) for s in states

  )
  $("#select_search_service_bill_state").trigger("change")
