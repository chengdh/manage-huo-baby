# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  Chart.defaults.global.responsive = true

  random_color = -> "##{Math.floor(Math.random()*16777215).toString(16)}"

  $('.select_org_multi').multipleSelect(
    placeholder : "请选择机构",
    multiple: true,
    selectAll: false
    # onClose: -> $(".multiple input").attr("disabled",true)
  )

  $('#mth').multipleSelect(
    placeholder : "请选择月份",
    multiple: true,
    selectAll: false
  )

  ctx = null
  myLineChart = null
  if $('#myChart').length
    ctx = $("#myChart").get(0).getContext("2d")

  get_chart_data = ->
    org_ids = $('#org_ids').multipleSelect("getSelects")
    org_ids_text = $('#org_ids').multipleSelect("getSelects","text")

    fee_type = $(".select_fee_type").val()
    chart_type = $(".select_chart_type").val()
    from_mth = null
    to_mth = null
    mths = null

    data_params =
        "org_ids[]" : org_ids,
        fee_type : fee_type

    data_to_org = false
    if $('#data_to_org').attr('checked')
      data_to_org = true
      data_params['data_to_org'] = true


    if $(".select_from_mth").length > 0 and $(".select_to_mth").length > 0
      from_mth = $(".select_from_mth").val()
      to_mth = $(".select_to_mth").val()
      data_params["from_mth"] = from_mth
      data_params["to_mth"] = to_mth

    if $('#mth').length > 0
      mths = $('#mth').multipleSelect("getSelects")
      data_params["mths[]"] = mths

    unless org_ids.length
      return

    $.ajax("/rpt_from_org_mths/data",
      dataType : 'json',
      data: data_params
    ).then((resp) ->
      if ctx
        data = parse_data(resp,org_ids,from_mth,to_mth,mths,fee_type)
        myLineChart.destroy() if myLineChart
        chart = new Chart(ctx)
        myLineChart = chart[chart_type].apply(chart,[data, {}])
        legend(document.getElementById("legend_wrapper"),data)
    )

  #解析from_mth to_mth为数组
  parse_mth = (f_mth,t_mth,mths) ->
    if mths
      return mths
    int_f_mth = parseInt(f_mth)
    int_t_mth = parseInt(t_mth)
    ret = (x.toString() for x in [int_f_mth..int_t_mth])
    ret.filter (m) -> parseInt(m.substring(4)) > 0 and parseInt(m.substring(4)) <= "12"

  #解析自服务端返回的数据
  parse_data = (resp,org_ids,f_mth,t_mth,mths,fee_type) ->
    datasets = []
    array_mths = parse_mth(f_mth,t_mth,mths)
    b_color = 0
    for org_id in org_ids
      dataset = merge_data(resp,org_id,array_mths,fee_type)
      datasets.push(dataset)

    {
      labels : array_mths,
      datasets: datasets
    }


  #合并自服务端传回的数据
  merge_data = (resp,org_id,array_mths,fee_type) ->
    array_fee = []
    orgs = resp.orgs.filter (o) -> o.id.toString() == org_id.toString()
    to_org_checked = $('#data_to_org').attr('checked')

    for mth in array_mths
      fee = 0
      if to_org_checked
        new_data = resp.result.filter (x) -> x.to_org_id.toString() == org_id and x.mth == mth
      else
        new_data = resp.result.filter (x) -> x.from_org_id.toString() == org_id and x.mth == mth

      for d in new_data
        fee += parseFloat(d["sum_" + fee_type])

      array_fee.push(fee)

    color = random_color()

    label: orgs[0].name,
    fillColor: color,
    strokeColor: color,
    pointColor: color,
    pointStrokeColor: "#fff",
    pointHighlightFill: "#fff",
    pointHighlightStroke: color,
    data: array_fee


  $('.btn_chart').click(get_chart_data)
