# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  #分成设置信息
  class DivideConfig
    @branch_bill_divide_rate: (from_org_id,to_org_id) ->
      data_params =
        "search[from_org_id_eq]": from_org_id,
        "search[to_org_id_eq]": to_org_id

      #返回的是$.Deferred对象
      $.getJSON('/divide_configs/branch_bill_divide_rate.json',data_params)


  #分公司运单对象
  class BranchBill
    constructor: (attrs)->
      @from_short_carrying_fee = 0
      @to_short_carrying_fee = 0
      @insured_fee = 2
      @goods_fee = 0
      @origin_carrying_fee = 0    #原运费
      @adjust_carrying_fee = 0    #调整运费
      @carrying_fee = 0           #原运费 + 调整运费
      @sum_carrying_fee = 0       #运费合计 = 当前运费 + 发货短途 + 到货短途 
      @sum_fee = 0                #运费合计 + 代收货款
      @sum_qty = 0

      @from_org_divide_fee = 0.0
      @to_org_divide_fee = 0.0
      @transit_org_divide_fee = 0.0
      @summary_org_divide_fee = 0.0


      if attrs
        $.extend(this,attrs)

    set_from_short_carrying_fee: (@from_short_carrying_fee) =>
    set_to_short_carrying_fee: (@to_short_carrying_fee) =>
    set_to_short_carrying_fee_slient: (@to_short_carrying_fee) =>
    set_carrying_fee: (@carrying_fee) => @calculate_fee()

    #silent 是否触发change event
    #insured_fee是系统自动计算的,不是手工输入的,不希望触发change事件
    set_insured_fee: (@insured_fee) => 
    set_insured_fee_slient: (@insured_fee) => 
    set_goods_fee: (@goods_fee) =>

    set_from_org_id: (@from_org_id) => @calculate_fee()

    set_to_org_id: (@to_org_id) => @calculate_fee()

    calculate_fee: =>
      $.Deferred(@calculate_divide_fee).then(=> $(this).trigger('change'))


    #计算分成费用
    calculate_divide_fee: (dtd)=>
      if @from_org_id == ""  or @to_org_id == ""
        @from_org_divide_fee = 0.0
        @to_org_divide_fee = 0.0
        @transit_org_divide_fee = 0.0
        @summary_org_divide_fee = 0.0
        dtd.resolve()
      else
        DivideConfig.branch_bill_divide_rate(@from_org_id,@to_org_id).then((divide_config) =>
          @from_org_divide_fee = @carrying_fee*divide_config.from_org[1]
          @transit_org_divide_fee = @carrying_fee*divide_config.transit_org[1]
          @to_org_divide_fee = @carrying_fee*divide_config.to_org[1]
          @summary_org_divide_fee = @carrying_fee*divide_config.summary_org[1]

          console.log("calculate divide fee")
          dtd.resolve()
        )
      return dtd.promise()

  #运单widget
  class BranchBillWidget
    constructor: (@el) ->

      attrs = @initial_vals()
      @model = new BranchBill(attrs)

      $(@model).on('change',@refresh)

      #绑定from_org_id和to_org_id变化事件
      $(@el).find('#from_org_id').change (evt) => 
        from_org_id = $(evt.target).val()
        @model.set_from_org_id(from_org_id)

      $(@el).find('#to_org_id').change (evt) => 
        to_org_id = $(evt.target).val()
        @model.set_to_org_id(to_org_id)

      $('#from_short_carrying_fee').change (evt) => 
        from_short_carrying_fee = parseFloat $(evt.target).val()
        @model.set_from_short_carrying_fee(from_short_carrying_fee)

      $('#to_short_carrying_fee').change (evt) => 
        to_short_carrying_fee = parseFloat $(evt.target).val()
        @model.set_to_short_carrying_fee(to_short_carrying_fee)

      $('#insured_fee').change (evt) => 
        insured_fee = parseFloat $(evt.target).val()
        @model.set_insured_fee(insured_fee)

      $('#goods_fee').change (evt) => 
        goods_fee = parseFloat $(evt.target).val()
        @model.set_goods_fee(goods_fee)
      $('#carrying_fee').change (evt) => 
        carrying_fee = parseFloat $(evt.target).val()
        @model.set_carrying_fee(carrying_fee)


    #从ui上获取初始数据
    initial_vals : =>
      from_org_id = $(@el).find("#from_org_id").val()
      to_org_id = $(@el).find("#to_org_id").val()

      from_short_carrying_fee = parseFloat($(@el).find("#from_short_carrying_fee").val())
      to_short_carrying_fee = parseFloat($(@el).find("#to_short_carrying_fee").val())
      insured_fee = parseFloat($(@el).find("#insured_fee").val())
      goods_fee = parseFloat($(@el).find("#goods_fee").val())
      carrying_fee = parseFloat($(@el).find("#carrying_fee").val())
      goods_num = parseFloat($(@el).find("#goods_num").val())

      ret =
        from_org_id: from_org_id,
        to_org_id: to_org_id,
        from_short_carrying_fee: from_short_carrying_fee,
        to_short_carrying_fee: to_short_carrying_fee,
        carrying_fee : carrying_fee,
        origin_carrying_fee : carrying_fee,
        goods_fee: goods_fee,
        insured_fee: insured_fee,

    refresh: =>
      insured_fee = parseFloat $('#insured_fee').val()
      @model.set_insured_fee_slient(insured_fee)
      to_short_carrying_fee = parseFloat $("#to_short_carrying_fee").val()
      @model.set_to_short_carrying_fee_slient(to_short_carrying_fee)

      $('.origin_carrying_fee').html(@model.origin_carrying_fee)
      $('#carrying_fee').val(@model.carrying_fee)

      $('.sum_carrying_fee').html(@model.sum_carrying_fee)
      $('#goods_num').val(@model.sum_qty)
      $('#goods_info').val(@model.goods_info)

      $('.sum_fee').html(@model.sum_fee)

      @refresh_divide_fee()
      #触发form#change事件,便于根据规则计算保价费
      #参考il_application.js#274

      $(@el).trigger('change')

    refresh_divide_fee: =>
      #分成金额
      $("#from_org_divide_fee").val(@model.from_org_divide_fee)
      $("#transit_org_divide_fee").val(@model.transit_org_divide_fee)
      $("#to_org_divide_fee").val(@model.to_org_divide_fee)
      $("#summary_org_divide_fee").val(@model.summary_org_divide_fee)
      $("#from_org_divide_fee_disp").html(@model.from_org_divide_fee)

  #构造一个新的运单显示对象
  $('form.branch_bill').livequery(->
    new BranchBillWidget($(this))
  )
