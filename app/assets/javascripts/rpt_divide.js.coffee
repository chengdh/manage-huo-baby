$ ->
  $('#tab_show_rpt_divide_branch_sum').click( ->
    $('#rpt_divide_branch_detail_wrapper').hide()
    $('#rpt_divide_branch_sum_wrapper').show()
  )

  $('#tab_show_rpt_divide_branch_detail').click( ->
    $('#rpt_divide_branch_detail_wrapper').show()
    $('#rpt_divide_branch_sum_wrapper').hide()
  )

  $('#tab_show_rpt_divide_department_sum').click( ->
    $('#rpt_divide_department_detail_wrapper').hide()
    $('#rpt_divide_department_sum_wrapper').show()
  )

  $('#tab_show_rpt_divide_department_detail').click( ->
    $('#rpt_divide_department_detail_wrapper').show()
    $('#rpt_divide_department_sum_wrapper').hide()
  )
