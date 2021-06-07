# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("form.inner_transit_bill").livequery(->
    selector = "form.inner_transit_bill #from_org_id,form.inner_transit_bill #to_org_id," +
              "form.inner_transit_bill #carrying_fee," +
              "form.inner_transit_bill #from_short_carrying_fee," +
              "form.inner_transit_bill #to_short_carrying_fee"
    $(selector).on("change", ->
      #获取分成配置信息
      from_org_id = $("form.inner_transit_bill #from_org_id").val()
      to_org_id = $("form.inner_transit_bill #to_org_id").val()
      carrying_fee = parseFloat($("form.inner_transit_bill #carrying_fee").val())
      manage_fee =  parseFloat($("form.inner_transit_bill #manage_fee").val())
      from_short_carrying_fee =  parseFloat($("form.inner_transit_bill #from_short_carrying_fee").val())
      to_short_carrying_fee =  parseFloat($("form.inner_transit_bill #to_short_carrying_fee").val())

      sum_carrying_fee = carrying_fee + from_short_carrying_fee + to_short_carrying_fee + manage_fee
      params = 
        from_org_id_eq: from_org_id,
        to_org_id_eq: to_org_id

      url = "/region_divide_configs/get_config.json"
      $.getJSON(url,params).then((config) ->
        if config != null
          from_rate = config.from_rate
          to_rate = config.to_rate
          summary_rate = config.summary_rate

          from_fee = Math.round(sum_carrying_fee * from_rate)
          to_fee =  Math.round(sum_carrying_fee * to_rate)
          summary_fee =  Math.round(sum_carrying_fee * summary_rate)
          $("#from_org_divide_fee").val(from_fee)
          $("#to_org_divide_fee").val(to_fee)
          $("#summary_org_divide_fee").val(summary_fee)
      )
    )
  )
