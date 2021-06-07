$ ->
  #中转运单中转操作,处理中转公司下拉列表变化事件
  $('#select_transit_company').on('change', ->
    if $(this).val() == ""
      $('#new_transit_company').show()
      $('[name*="transit_company_attributes"]').attr('disabled', false)
    else
      $('#new_transit_company').hide()
      $('[name*="transit_company_attributes"]').attr('disabled', true)
  )
