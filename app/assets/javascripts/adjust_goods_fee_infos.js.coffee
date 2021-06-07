# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if $("#adjust_goods_fee_search_box").val() != ""
    $("#adjust_goods_fee_search_box").trigger(jQuery.Event('keypress', { keyCode: 13 }))

  $(".adjust_fee_info_line input[data-bill]").livequery(->
    bill = $(this).data("bill")
    $("#adjust_goods_fee_info_adjust_goods_fee").val(bill.goods_fee)
  )
