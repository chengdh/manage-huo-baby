$ ->
  #运费金额设置信息
  class FeeConfig
    @get_config: (goods_cat_id,from_org_id,to_org_id) ->
      data_params =
        "search[goods_cat_fee_config_from_org_id_eq]": from_org_id
        "search[goods_cat_fee_config_to_org_id_eq]": to_org_id
        "search[goods_cat_id_eq]": goods_cat_id

      #返回的是$.Deferred对象
      $.getJSON('/goods_cat_fee_configs/single_config_line.json',data_params)

  #自动计算运单对象
  class Bill
    constructor: (attrs)->
      @lines = []
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

      if attrs
        $.extend(this,attrs)

    set_from_short_carrying_fee: (@from_short_carrying_fee) => @calculate_fee()
    set_to_short_carrying_fee: (@to_short_carrying_fee) => @calculate_fee()
    set_to_short_carrying_fee_slient: (@to_short_carrying_fee) => @calculate_fee_silent()
    #silent 是否触发change event
    #insured_fee是系统自动计算的,不是手工输入的,不希望触发change事件
    set_insured_fee: (@insured_fee) => @calculate_fee()
    set_insured_fee_slient: (@insured_fee) => @calculate_fee_silent()
    set_goods_fee: (@goods_fee) => @calculate_fee()
    set_adjust_carrying_fee: (@adjust_carrying_fee) => @calculate_fee()

    set_from_org_id: (@from_org_id) => 
      arrays = (l.calculate_fee() for l in @lines)
      $.when.apply($,arrays).then(@calculate_fee)

    set_to_org_id: (@to_org_id) => 
      arrays = (l.calculate_fee() for l in @lines)
      $.when.apply($,arrays).then(@calculate_fee)

    add_line: (line) =>
      @lines.push(line)
      @calculate_fee()

    remove_line: (line) => 
      index_line = @lines.indexOf(line)
      @lines.splice(index_line,1)
      @calculate_fee()

    calculate_fee: =>
      @calculate_fee_silent()
      #触发变化事件
      $(this).trigger('change')

    #silent 是否触发change事件 false 触发 true 不触发
    calculate_fee_silent: =>
      @sum_carrying_fee = 0
      @origin_carrying_fee = 0
      @carrying_fee = 0
      @sum_fee = 0
      @sum_qty = 0
      for l in @lines
        @origin_carrying_fee += l.amt
        @sum_qty += l.qty

      @origin_carrying_fee = Math.ceil(@origin_carrying_fee)
      #对合计进行上舍入操作
      @carrying_fee = Math.ceil(@origin_carrying_fee + @adjust_carrying_fee)
      @sum_carrying_fee = Math.ceil(@carrying_fee + @from_short_carrying_fee + @to_short_carrying_fee)
      @sum_fee = @sum_carrying_fee + @insured_fee + @goods_fee
      @goods_info = @lines[0].goods_cat_name
 

  #运单widget
  class BillWidget
    constructor: (@el) ->

      $(@el).find("#carrying_fee").attr("readonly",true)
      attrs = @initial_vals()
      @model = new Bill(attrs)

      @lines_widget = []
      @lines_widget.push(new BillLineWidget(line_el,@model)) for line_el in $('.line_tr')
      $(@model).on('change',@refresh)

      #绑定from_org_id和to_org_id变化事件
      $(@el).find('#from_org_id').change (evt) => 
        from_org_id = $(evt.target).val()
        @model.set_from_org_id(from_org_id)

      #from_org_id 有默认值
      #$(@el).find('#from_org_id').trigger('change')

      $(@el).find('#to_org_id').change (evt) => 
        to_org_id = $(evt.target).val()
        @model.set_to_org_id(to_org_id)

      $('#from_short_carrying_fee').change (evt) => 
        from_short_carrying_fee = parseFloat $(evt.target).val()
        @model.set_from_short_carrying_fee(from_short_carrying_fee)

      $('#to_short_carrying_fee').change (evt) => 
        to_short_carrying_fee = parseFloat $(evt.target).val()
        @model.set_to_short_carrying_fee(to_short_carrying_fee)

      $('#adjust_carrying_fee').change (evt) => 
        adjust_carrying_fee = parseFloat $(evt.target).val()
        @model.set_adjust_carrying_fee(adjust_carrying_fee)


      $('#insured_fee').change (evt) => 
        insured_fee = parseFloat $(evt.target).val()
        @model.set_insured_fee(insured_fee)

      $('#goods_fee').change (evt) => 
        goods_fee = parseFloat $(evt.target).val()
        @model.set_goods_fee(goods_fee)

      $('#adjust_carrying_fee').change()

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
      line_widget.refresh() for line_widget in @lines_widget
      insured_fee = parseFloat $('#insured_fee').val()
      @model.set_insured_fee_slient(insured_fee)
      to_short_carrying_fee = parseFloat $("#to_short_carrying_fee").val()
      @model.set_to_short_carrying_fee_slient(to_short_carrying_fee)

      $('.origin_carrying_fee').html(@model.origin_carrying_fee)
      $('#carrying_fee').val(@model.carrying_fee)

      $('.sum_carrying_fee').html(@model.sum_carrying_fee)
      goods_num = @model.sum_qty
      $('#goods_num').val(goods_num)

      #更新货号
      goods_no = $(".goods_no").val()
      new_goods_no = goods_no.replace( /\d+$/,goods_num)
      goods_no = $(".goods_no").val(new_goods_no)


      $('#goods_info').val(@model.goods_info)

      $('.sum_fee').html(@model.sum_fee)

      #触发form#change事件,便于根据规则计算保价费
      #参考il_application.js#274

      $(@el).trigger('change')

  #运单明细
  class BillLine
    constructor: (@bill,attrs) -> 
      @bill.add_line(this)
      @volume = 0
      @qty = 0
      if attrs
        $.extend(this,attrs)

    set_goods_cat_id: (@goods_cat_id) => @calculate_fee()
    set_volume: (@volume) =>
    set_qty: (@qty) => @calculate_fee()

    reset: =>
      @qty = 0
      @volume = 0
      @weight = 0
      @unit_price = 0
      @amt = 0
      @bill.calculate_fee()

    calculate_fee: =>
      FeeConfig.get_config(@goods_cat_id,@bill.from_org_id,@bill.to_org_id).then((fee_config) =>
        if fee_config
          @qty = 1 if @qty == 0
          @volume = 1 if @volume == 0
          @weight = 1 if @weight == 0

          @unit_price = parseFloat fee_config.unit_price
          #底价
          @bottom_price = parseFloat fee_config.bottom_price
          @amt = @unit_price*@qty
          @amt = @bottom_price if @amt < @bottom_price
          #对合计进行上舍入操作
          @amt = Math.ceil(@amt)
          @goods_cat_name = fee_config.goods_cat_name
        else
          @unit_price = 0
          @bottom_price = 0
          @amt = 0
          @qty = 0
          @weight = 0
          @volume = 0
          @goods_cat_name = ''
          ).then(@bill.calculate_fee)

  #明细对象
  class BillLineWidget
    #构造函数
    #@el jquery element
    constructor : (@el,@bill) ->
      attrs = @initial_vals()
      $(@el).find(".price").attr("readonly",true)
      $(@el).find(".amt").attr("readonly",true)
      @model = new BillLine(@bill,attrs)

      #如果有初始化数据,则显示该Line
      if attrs.goods_cat_id
        $(@el).show()

      #货物分类变化
      $(@el).find('.goods_cat_id').change (evt) => 
        current_el = $(evt.target)
        @model.set_goods_cat_id(current_el.val())

      #货物体积发生变化
      $(@el).find('.volume').change (evt) => 
        current_el = $(evt.target)
        @model.set_volume(parseFloat(current_el.val()))

      #货物数量发生变化
      $(@el).find('.qty').change (evt) => 
        current_el = $(evt.target)
        @model.set_qty(parseFloat(current_el.val()))

      #删除事件绑定
      $(@el).find(".btn-delete-line").click (evt) =>
        @model.reset()
        $(@el).hide()

      $(@el).find('.qty').change()

    initial_vals: =>
      goods_cat_id = $(@el).find('.goods_cat_id').val()
      price = parseFloat $(@el).find('.price').val()
      qty = parseFloat $(@el).find('.qty').val()
      amt = parseFloat $(@el).find('.amt').val()
      ret = 
        goods_cat_id : goods_cat_id,
        qty : qty,
        unit_price : price,
        amt : amt

      return ret

    refresh: =>
      $(@el).find('.amt').val(@model.amt)
      $(@el).find('.price').val(@model.unit_price)
      $(@el).find('.bottom_price').html(@model.bottom_price)
      $(@el).find('.qty').val(@model.qty)
      $(@el).find('.volume').val(@model.volume)
      #$(@el).find('.weight').val(@model.weight)

  #构造一个新的运单显示对象
  $('form.auto_calculate_computer_bill .goods_cat_id').livequery(-> $(this).ufd())
  $('form.auto_calculate_computer_bill').livequery(->
    new BillWidget($(this))
    $('form.auto_calculate_computer_bill .line_tr').first().show()
  )
  $('form.auto_calculate_computer_bill .btn-add-bill-line').on('click', ->
    $('form.auto_calculate_computer_bill .line_tr[style*="display: none"]').first().show()
  )

  #首行不可删除
  $('form.auto_calculate_computer_bill .line_tr:first .btn-delete-line').hide()
  #new BillWidget($('.auto_calculate_computer_bill'))
