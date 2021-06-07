# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $(document).on("ajax:before",'#from_short_fee_info_form', ->
    bill_els = $('[data-bill]')
    bill_ids = []
    if bill_els.length == 0
      $.notifyBar(
        html: "未查找到任何运单,请先查询要处理的运单",
        delay: 3000,
        animationSpeed: "normal",
        cls: 'error'
      )
      return false
    else
      for el in bill_els
        bill = $(el).data('bill')

        bill_id = bill.id
        bill_ids.push(bill_id)

      $(this).data('params',"bill_ids[]": bill_ids)
      return true
  )
