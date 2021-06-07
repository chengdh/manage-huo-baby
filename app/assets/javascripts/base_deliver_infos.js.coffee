# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $(document).on("ajax:before",'#deliver_info_form,#inner_transit_deliver_info_form,#local_town_deliver_info_form', ->
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

  #外部中转提货单,切换正常提货与退货单提货
  $('#cbx_transit_deliver_info_return_bill').on('change', ->
    if this.checked
      $('.search_box_transit_deliver_info').data('params',
        "search[state_eq]" : "reached",
        "search[type_in][]" : ["OutterTransitReturnBill"],
        "hide_fields" : ".carrying_fee,.note,.customer",
        "show_fields" :  ".insured_fee_th,.carrying_fee_th_total,.th_amount,.transit_carrying_fee,.transit_hand_fee",
        "show_multi" : 1
      )
    else
      $('.search_box_transit_deliver_info').data('params',
        "search[state_eq]" : "transited",
        "search[type_in][]" : ["TransitBill","HandTransitBill"],
        "hide_fields" : ".carrying_fee,.note,.customer",
        "show_fields" :  ".insured_fee_th,.carrying_fee_th_total,.th_amount,.transit_hand_fee_edit,.transit_to_phone,.transit_bill_no,.transit_company",
        "show_multi" : 1
      )
  )
