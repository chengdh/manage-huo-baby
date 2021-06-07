$ ->
  $(".tr_rpt_branch_mc .txt_now_debts,.tr_rpt_branch_mc .txt_act_pay_fee").on("change", ->
    tr = $(this).parents("tr.tr_rpt_branch_mc")
    now_debts_el = $(tr).find(".txt_now_debts")
    th_amount_no_reached_el = $(tr).find(".th_amount_no_reached")
    th_amount_today_bills_el = $(tr).find(".th_amount_today_bills")
    th_amount_inner_today_refund_el = $(tr).find(".th_amount_inner_today_refund")
    sum_th_amount_el = $(tr).find(".sum_th_amount")
    txt_act_pay_fee_el = $(tr).find(".txt_act_pay_fee")
    sum_diff_el = $(tr).find(".sum_diff")

    now_debts = parseFloat(now_debts_el.val())
    th_amount_no_reached = parseFloat(th_amount_no_reached_el.html())
    th_amount_today_bills = parseFloat(th_amount_today_bills_el.html())
    th_amount_inner_today_refund = parseFloat(th_amount_inner_today_refund_el.html())
    sum_th_amount = now_debts + th_amount_no_reached + th_amount_today_bills + th_amount_inner_today_refund
    act_pay_fee = parseFloat(txt_act_pay_fee_el.val())
    sum_diff = act_pay_fee - sum_th_amount
    $(sum_th_amount_el).html(sum_th_amount)
    $(sum_diff_el).html(sum_diff)
  )
