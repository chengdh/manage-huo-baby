# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#divide_rpt_yujiu_form").on("change", -> 
    #分成合计
    sum_divide_fee = 0
    sum_divide_fee += parseFloat($(el).val()) for el in $(".divide_fee")

    #应补合计
    sum_plus_fee = 0
    sum_plus_fee += parseFloat($(el).val()) for el in $(".plus_fee")


    #应扣合计
    sum_deduct_fee = 0
    sum_deduct_fee += parseFloat($(el).val()) for el in $(".deduct_fee")


    #其他应扣合计
    sum_other_deduct_fee = 0
    sum_other_deduct_fee += parseFloat($(el).val()) for el in $(".other_deduct_fee")

    #合计金额
    sum_fee = sum_divide_fee + sum_plus_fee - sum_deduct_fee - sum_other_deduct_fee

    $("#sum_divide_fee").html(sum_divide_fee)
    $("#sum_plus_fee").html(sum_plus_fee)
    $("#sum_deduct_fee").html(sum_deduct_fee)
    $("#sum_other_deduct_fee").html(sum_other_deduct_fee)
    $("#sum_fee").html(sum_fee)
    $("#sum_fee_chinese").html($.num2chinese(sum_fee.toString()))
  )
