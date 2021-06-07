# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.in_stock_bill_lines_wrapper #bills_table_body').on('tr_changed', ->
    $(el).remove() for el in $('.in_stock_bill_lines_wrapper tr[data-bill]') when $(el).data('bill').is_debt_bill
    $('#bills_table_body').trigger('re_cal_sum')
  )

