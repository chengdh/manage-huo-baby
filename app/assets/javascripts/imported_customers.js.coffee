$ ->
  # $(document).on("change","#cbx_code_is_not_null_in_search_imported_customer", ->
  #   if this.checked
  #     $(this).attr('disabled',false)
  #     $('#cbx_code_is_null_in_search_imported_customer').attr('disabled',true)
  #   else
  #     $(this).attr('disabled',true)
  #     $('#cbx_code_is_null_in_search_imported_customer').attr('disabled',false)
  # )
  # $(document).on("change","#cbx_code_is_null_in_search_imported_customer", ->
  #   if this.checked
  #     $(this).attr('disabled',false)
  #     $('#cbx_code_is_not_null_in_search_imported_customer').attr('disabled',true)
  #   else
  #     $(this).attr('disabled',true)
  #     $('#cbx_code_is_not_null_in_search_imported_customer').attr('disabled',false)
  # )
  $("#btn_imported_customer_query_submit").on("click", ->
    check = true
    if $("#search_code").length > 0 and $("#search_code").val() == ""
      $("#search_code").notify("请输入客户卡号!","error")
      check = false

    if $("#search_name").length > 0 and $("#search_name").val() == ""
      $("#search_name").notify("请输入客户姓名!","error")
      check = false

    if check
      $("#imported_customer_search_service_form").submit()

  )

