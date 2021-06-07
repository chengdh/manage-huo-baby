//运单打印相关函数的封装
jQuery(function($) {
  $.extend({
    //判断是否已安装打印控件
    //已安装,返回true
    //未安装,返回false
    check_lodop: function() {
      var print_object = $.get_print_object();
      if ((print_object == null) || (typeof(print_object.VERSION) == "undefined") || print_object.VERSION < "6.1.2.0") {
        // var download_bar = $("<div id='notify-down-print-object' class='notify'><span class='notify-text'>系统检测到您的浏览器需要安装打印控件,请点击<a href='/assets/install_lodop32.exe'>此处</a>下载安装,安装后关闭浏览器并重新进入系统.</span></div>");
        // $('#notify-down-print-object').remove();
        // $('#notify-bar').after(download_bar);

        return false;
      }
      //设置注册码
      print_object.SET_LICENSES("","477941089793108118118112110123","688858710010010811411756128900","");
      return true;
    },
    //获取打印控件,可以在chrome safari下使用,在ie下,该函数被重写
    get_print_object: function() {
      var print_object = getLodop();
      return print_object;

      //先看看是否存在print对象
      /*
      if ($('#print_object').length == 0) {
        var print_object = $('<span id="print_object"><object id="print_object_ie" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0><embed id="print_object_other" type="application/x-print-lodop" width=0 height=0></embed></object></span>');
        $('body').append(print_object);
      }
      var lodop = null;
      //判断返回那个对象
      if ($.browser.msie) lodop =  print_object_ie;
      else lodop =  print_object_other;
      return lodop;
      */
    }
  });
  $.extend({
    //得到运单打印设置
    get_print_config: function(the_bill) {
      var config = {
        page: {
          name: "运单打印-" + the_bill.bill_no,
          width: "210mm",
          height: '140mm',
          left: '0',
          top: '-8mm',
          style: {
            FontSize: 13,
            LineSpacing: 13
          }

        },
        from_org: {
          text: the_bill.from_org.name,
          left: '38mm',
          top: '13mm',
          width: '35mm',
          height: '6mm'
        },
        to_org: {
          text: (the_bill.to_org ? the_bill.to_org.name: "") + (the_bill.area ? the_bill.area.name: ""),
          left: '100mm',
          top: '13mm',
          width: '30mm',
          height: '6mm'
        },
        bill_no: {
          text: the_bill.bill_no,
          left: '160mm',
          top: '13mm',
          width: '30mm',
          height: '6mm'
        },
        customer_code_1: {
          text: the_bill.customer_code ? the_bill.customer_code.substr(0, 1) : "",
          left: '31mm',
          top: '22mm',
          width: '6mm',
          height: '6mm',
          style: {
            FontSize: 14
          }

        },
        customer_code_2: {
          text: the_bill.customer_code ? the_bill.customer_code.substr(1, 1) : "",
          left: '38mm',
          top: '22mm',
          width: '6mm',
          height: '6mm',
          style: {
            FontSize: 14
          }

        },
        customer_code_3: {
          text: the_bill.customer_code ? the_bill.customer_code.substr(2, 1) : "",
          left: '45mm',
          top: '22mm',
          width: '6mm',
          height: '6mm',
          style: {
            FontSize: 14
          }

        },
        customer_code_4: {
          text: the_bill.customer_code ? the_bill.customer_code.substr(3, 1) : "",
          left: '52mm',
          top: '22mm',
          width: '6mm',
          height: '6mm',
          style: {
            FontSize: 14
          }

        },
        customer_code_5: {
          text: the_bill.customer_code ? the_bill.customer_code.substr(4, 1) : "",
          left: '60mm',
          top: '22mm',
          width: '6mm',
          height: '6mm',
          style: {
            FontSize: 14
          }

        },
        customer_code_6: {
          text: the_bill.customer_code ? the_bill.customer_code.substr(5, 1) : "",
          left: '67mm',
          top: '22mm',
          width: '6mm',
          height: '6mm',
          style: {
            FontSize: 14
          }

        },
        customer_code_7: {
          text: the_bill.customer_code ? the_bill.customer_code.substr(6, 1) : "",
          left: '74mm',
          top: '22mm',
          width: '6mm',
          height: '6mm',
          style: {
            FontSize: 14
          }

        },

        goods_no: {
          text: the_bill.goods_no.substring(4),
          left: '110mm',
          top: '22mm',
          width: '40mm',
          height: '6mm'
        },
        bill_date_year: {
          text: the_bill.bill_date.substr(0, 4),
          left: '157mm',
          top: '22mm',
          width: '13mm',
          height: '6mm',
          style: {
            FontSize: 15
          }

        },
        bill_date_mth: {
          text: the_bill.bill_date.substr(5, 2),
          left: '175mm',
          top: '22mm',
          width: '10mm',
          height: '6mm',
          style: {
            FontSize: 15
          }

        },
        bill_date_day: {
          text: the_bill.bill_date.substr(8, 2),
          left: '185mm',
          top: '22mm',
          width: '10mm',
          height: '6mm',
          style: {
            FontSize: 15
          }
        },

        from_customer_name: {
          text: the_bill.from_customer_name,
          left: '39mm',
          top: '30mm',
          width: '26mm',
          height: '6mm'
        },
        from_customer_phone: {
          text: the_bill.from_customer_phone,
          left: '74mm',
          top: '30mm',
          width: '35mm',
          height: '6mm'
        },
        from_customer_mobile: {
          text: the_bill.from_customer_mobile,
          left: '118mm',
          top: '30mm',
          width: '40mm',
          height: '6mm'
        },
        to_customer_name: {
          text: the_bill.to_customer_name,
          left: '39mm',
          top: '37mm',
          width: '26mm',
          height: '6mm'
        },
        to_customer_phone: {
          text: the_bill.to_customer_phone,
          left: '74mm',
          top: '37mm',
          width: '35mm',
          height: '6mm'
        },
        to_customer_mobile: {
          text: the_bill.to_customer_mobile,
          left: '118mm',
          top: '37mm',
          width: '40mm',
          height: '6mm'
        },
        pay_type_des: {
          text: the_bill.pay_type_des,
          left: '160mm',
          top: '37mm',
          width: '35mm',
          height: '6mm'
        },

        goods_info: {
          text: the_bill.goods_info,
          left: '19mm',
          top: '52mm',
          width: '20mm',
          height: '7mm'
        },
        goods_package: {
          text: the_bill.package,
          left: '39mm',
          top: '52mm',
          width: '13mm',
          height: '7mm'
        },
        goods_num: {
          text: the_bill.goods_num,
          left: '52mm',
          top: '52mm',
          width: '13mm',
          height: '7mm'
        },
        carrying_fee: {
          text: the_bill.carrying_fee,
          left: '65mm',
          top: '52mm',
          width: '18mm',
          height: '7mm'
        },
        th_amount_chinese: {
          text: $.num2chinese(the_bill.th_amount),
          left: '110mm',
          top: '45mm',
          width: '62mm',
          height: '6mm'
        },
        th_amount: {
          text: the_bill.th_amount,
          left: '177mm',
          top: '45mm',
          width: '20mm',
          height: '6mm'
        },
        insured_fee_chinese: {
          text: $.num2chinese(the_bill.type == 'InnerTransitBill' ? "0.0" : the_bill.insured_fee),
          left: '130mm',
          top: '51mm',
          width: '62mm',
          height: '7mm'
        },

        insured_fee: {
          //内部中转运单,保险费全部计入运费中
          //20130916
          text: the_bill.type == 'InnerTransitBill' ? "0.0" : the_bill.insured_fee,
          left: '177mm',
          top: '51mm',
          width: '20mm',
          height: '6mm'
        },
        from_short_carrying_fee: {
          text: the_bill.from_short_carrying_fee,
          left: '39mm',
          top: '58mm',
          width: '15mm',
          height: '6mm'
        },
        to_short_carrying_fee: {
          text: the_bill.to_short_carrying_fee,
          left: '70mm',
          top: '58mm',
          width: '15mm',
          height: '6mm'
        },

        carrying_fee_total_chinese: {
          // text: $.num2chinese(the_bill.type == 'InnerTransitBill' ? (parseFloat(the_bill.manage_fee) + parseFloat(the_bill.carrying_fee_total)).toString() : the_bill.carrying_fee_total),
          text: $.num2chinese(parseFloat(the_bill.carrying_fee_total).toString()),
          left: '110mm',
          top: '58mm',
          width: '62mm',
          height: '6mm'
        },
        carrying_fee_total: {
          //内部中转运单,保险费全部计入运费中
          //20130916
          // text: the_bill.type == 'InnerTransitBill' ? (parseFloat(the_bill.manage_fee) + parseFloat(the_bill.carrying_fee_total)).toString() : the_bill.carrying_fee_total,
          text: the_bill.carrying_fee_total,
          left: '177mm',
          top: '58mm',
          width: '20mm',
          height: '6mm'
        },
        note: {
          text: the_bill.note,
          left: '35mm',
          top: '66mm',
          width: '50mm',
          height: '6mm',
          style: {
            FontSize: 10,
            LineSpacing: 1
          }

        },

        goods_fee_chinese: {
          text: $.num2chinese(the_bill.goods_fee),
          left: '110mm',
          top: '66mm',
          width: '62mm',
          height: '6mm'
        },
        goods_fee: {
          text: the_bill.goods_fee,
          left: '177mm',
          top: '66mm',
          width: '20mm',
          height: '6mm'
        },

        user: {
          text: the_bill.user.real_name,
          left: '35mm',
          top: '82mm',
          width: '25mm',
          height: '6mm'
        },

        from_org_phone: {
          text: the_bill.from_org.name + "(" + the_bill.from_org.location + "):" + the_bill.from_org.phone,
          left: '25mm',
          top: '120mm',
          width: '90mm',
          height: '6mm'
        },

        to_org_phone: {
          text: the_bill.to_org ? (the_bill.to_org.name + ":" + the_bill.to_org.phone) : (the_bill.transit_org.name + ":" + the_bill.transit_org.phone),
          left: '25mm',
          top: '125mm',
          width: '90mm',
          height: '6mm'
        },
        print_counter: {
          text: (the_bill.print_counter + 1) + "次打印",
          left:   '145mm',
          top:    '126mm',
          width:  '20mm',
          height: '6mm'
        },

        created_at_str: {
          text: the_bill.created_at_str.substring(9),
          left:   '170mm',
          top:    '126mm',
          width:  '50mm',
          height: '6mm'
        }
      };
      return config;
    },

    //打印运单
    print_bill: function(config) {
      if (!$.check_lodop()) return false;
      var print_object = $.get_print_object();
      print_object.PRINT_INITA(config.page.top, config.page.left, config.page.width, config.page.height, config.page.name);
      print_object.SET_PRINT_PAGESIZE(1, config.page.width, config.page.height, "");
      for (var c in config) {
        if (typeof(config[c].text) != 'undefined') print_object.ADD_PRINT_TEXT(config[c].top, config[c].left, config[c].width, config[c].height, config[c].text);
        print_object.SET_PRINT_STYLEA(0, "FontSize", 13);
        print_object.SET_PRINT_STYLEA(0, "LineSpacing", 10);
        //判断有无特殊打印格式
        if (typeof(config[c].style) != 'undefined') {
          var the_style = config[c].style;
          for (var s in the_style)
            print_object.SET_PRINT_STYLEA(0, s, the_style[s]);
        }
      }
      //print_object.PREVIEW();
      print_object.PRINT();
      return true;
    },
    //打印运单,同时带条码
    print_bill_with_barcode: function(config,bill) {
      if (!$.check_lodop()) return false;
      var print_object = $.get_print_object();
      print_object.PRINT_INITA(config.page.top, config.page.left, config.page.width, config.page.height, config.page.name);
      print_object.SET_PRINT_PAGESIZE(1, config.page.width, config.page.height, "");
      for (var c in config) {
        if (typeof(config[c].text) != 'undefined') print_object.ADD_PRINT_TEXT(config[c].top, config[c].left, config[c].width, config[c].height, config[c].text);
        print_object.SET_PRINT_STYLEA(0, "FontSize", 13);
        print_object.SET_PRINT_STYLEA(0, "LineSpacing", 10);
        //判断有无特殊打印格式
        if (typeof(config[c].style) != 'undefined') {
          var the_style = config[c].style;
          for (var s in the_style)
            print_object.SET_PRINT_STYLEA(0, s, the_style[s]);
        }
      }
      //print_object.PREVIEW();
      //添加打印条码
      print_object.ADD_PRINT_BARCODE('95mm','140mm',200,50,'128A',bill.bill_no);
      print_object.PRINT();
      return true;
    },
    //打印html内容
    print_html: function(config) {
      if (!$.check_lodop()) return;
      var print_object = $.get_print_object();
      print_object.PRINT_INITA(config.top, config.left, config.width, config.height, config.print_name);
      //添加content
      print_object.ADD_PRINT_HTM(config.top, config.left, config.width, config.height, config.content);

      var orient = 1;
      if(config.orient)
        orient = config.orient;
      print_object.SET_PRINT_PAGESIZE(orient, config.width, config.height, "");
      if(config.printer_index)
        set_printer_ret = print_object.SET_PRINTER_INDEX(config.printer_index);
      if(config.preview)
        print_object.PREVIEW();
      else
        print_object.PRINT();
    },

    //打印条码
    //printer string 条码打印机名称
    //the_bill object 要打印的运单
    //f_seq 条码起始序号 1 开始
    //t_seq 条码结束序号 货物数量 结束
    print_barcode : function(the_bill,f_seq,t_seq,print_template){
      if (!$.check_lodop()) return;
      var print_object = $.get_print_object();

      // var barcode_printer_index = $.get_barcode_printer_index();
      // if(barcode_printer_index < 0){ 
      //   //设置当前条码打印机
      //   $.notifyBar({
      //     html: "没有安装设置条码打印机!",
      //     delay: 3000,
      //     animationSpeed: "normal",
      //     cls: 'error'
      //   });
      //   return false;
      // }
      //
      var barcode_printer_index = 0;
      //以下打印条形码
      var print_array = $.generate_barcode_html(the_bill,f_seq,t_seq,print_template);
      for(var i=0;i < print_array.length;i++){
        var config = {
          print_name: "打印条码",
          top:    "0",
          left:   "0",
          width:  "90mm",
          height: "60mm",
          content: print_array[i].html(),
          //printer_index : barcode_printer_index,
          preview : false
        };

        $.print_html(config);
      }
      //var print_html = $.generate_barcode_html(the_bill,f_seq,t_seq).html();
      return true;
    },

    //获取打印机
    get_printer_index: function(a_pattern){
      if (!$.check_lodop()) return;
      var print_object = $.get_print_object();
      var printer_count = print_object.GET_PRINTER_COUNT();
      if(printer_count == 0){
        $.notifyBar({
          html: "您未安装任何打印机!",
          delay: 3000,
          animationSpeed: "normal",
          cls: 'error'
        });
        return -100;
      }
      var barcode_printer_index = -100;
      //查找条码打印机,通过名字测试来匹配
      for(var p_index = 0;p_index < printer_count;p_index++){
        var p_name = print_object.GET_PRINTER_NAME(p_index);
        var ret = a_pattern.test(p_name);
        if(ret){
          barcode_printer_index = p_index;
          barcode_printer_index = p_name;
          break;
        }
      }
      return barcode_printer_index;
    },

    //获取条码打印机
    get_barcode_printer_index: function(){
      var pattern = /(tsc|TSC|zebra|ZEBRA)/gi;
      return $.get_printer_index(pattern);
    },
    //获取热敏打印机
    get_thermal_printer_index: function(){
      var pattern = /(thermal|THERMAL)/gi;
      return $.get_printer_index(pattern);
    },



    //生成运单条形码
    //the_bill object 运单对象
    //f_seq 起始序号
    //t_seq 结束序号
    //条码编码格式:
    //到货地id(3位)|运单号(7位)|总件数(3位)|序号(3位)
    generate_barcode : function(the_bill,f_seq,t_seq){
      ret = new Array();
      //补零操作
      var add_zero = function(str,length){
        return new Array(length - str.length + 1).join("0") + str;
      }
      for(var i=f_seq;i<=t_seq;i++){
        var s_to_org_id = add_zero(the_bill.to_org_id.toString(),3);
        var bill_no = the_bill.bill_no;
        var s_goods_num = add_zero(the_bill.goods_num.toString(),3);
        var s_seq = add_zero(i.toString(),3);
        var barcode = s_to_org_id + bill_no + s_goods_num + s_seq;
        ret.push(barcode);
      }
      return ret;
    },
    //生成条码打印html
    generate_barcode_html : function(the_bill,f_seq,t_seq,print_template){
      var barcode_array = $.generate_barcode(the_bill,f_seq,t_seq);
      var print_array = new Array();
      for(var i=barcode_array.length -1 ;i >=0 ;i--){
        var barcode_wrapper = $("<div style='padding : 0;margin : 0;height : 70mm;overflow-y : hidden'></div>");
        var barcode = barcode_array[i];
        the_bill.seq = f_seq + i;
        the_bill.barcode = barcode;
        var label_html = nano(print_template,the_bill);

        var el_barcode = $(label_html);
        el_barcode.find('.barcode').barcode(barcode, "code128",{showHRI : true});
        barcode_wrapper.append(el_barcode);
        print_array.push(barcode_wrapper);
        // $('body').append(barcode_wrapper);
      }
      return print_array;
    }
  });

  //绑定打印事件
  $('.print_carrying_bill').click(function() {
    var self = this;
    if ($(this).data('printed')) $.notifyBar({
      html: "请点击[刷新]按钮后再重新打印运单!",
      delay: 3000,
      animationSpeed: "normal",
      cls: 'error'
    });

    else {
      var bill = $(this).data('print');
      //打印计数
      var print_counter_url = "";
      if (bill.type == 'ComputerBill') print_counter_url = "/computer_bills/" + bill.id + "/print_counter";
      if (bill.type == 'TransitBill') print_counter_url = "/transit_bills/" + bill.id + "/print_counter";
      if (bill.type == 'InnerTransitBill') print_counter_url = "/inner_transit_bills/" + bill.id + "/print_counter";
      if (bill.type == 'LocalTownBill') print_counter_url = "/local_town_bills/" + bill.id + "/print_counter";
      if (bill.type == 'ReturnBill') print_counter_url = "/return_bills/" + bill.id + "/print_counter";
      if (bill.type == 'AutoCalculateComputerBill') print_counter_url = "/auto_calculate_computer_bills/" + bill.id + "/print_counter";
      $.ajax({
        url: print_counter_url,
        type: 'PUT',
        success: function() {
          $('#bill_print_counter').html((bill.print_counter + 1) + "次打印");
        }
      }).then(function(){
        var config = $.get_print_config(bill);
        // var ret = $.print_bill(config);
        var ret = $.print_bill_with_barcode(config,bill);
        $(self).data('printed', true);
      });
    }
  });

  //打印热敏运单及标签运单
  $('.print_thermal_carrying_bill,.print_carrying_bill_v2 ').on('click',function() {
    var self = this;
    // var printer_index = $.get_thermal_printer_index();
    //   if(printer_index < 0){ 
    //     //设置当前条码打印机
    //     $.notifyBar({
    //       html: "没有安装设置热敏打印机!",
    //       delay: 3000,
    //       animationSpeed: "normal",
    //       cls: 'error'
    //     });
    //     return false;
    //   }
    var printer_index = 0;

    if ($(this).data('printed')) $.notifyBar({
      html: "请点击[刷新]按钮后再重新打印运单!",
      delay: 3000,
      animationSpeed: "normal",
      cls: 'error'
    });
    else {
      var bill = $(this).data('print');
      //打印计数
      var print_counter_url = "";
      if (bill.type == 'ComputerBill') print_counter_url = "/computer_bills/" + bill.id + "/print_counter";
      if (bill.type == 'TransitBill') print_counter_url = "/transit_bills/" + bill.id + "/print_counter";
      if (bill.type == 'ReturnBill') print_counter_url = "/return_bills/" + bill.id + "/print_counter";
      if (bill.type == 'AutoCalculateComputerBill') print_counter_url = "/auto_calculate_computer_bills/" + bill.id + "/print_counter";
      $.ajax({
        url: print_counter_url,
        type: 'PUT',
        success: function() {
          $('#bill_print_counter').html((bill.print_counter + 1) + "次打印");
        }
      }).then(function(){

        var wrapper = $("<div style='padding : 0;margin : 0;'></div>");
        var print_content = $(self).data("print-bill");
        var el_print_content = $(print_content);
        // el_print_content.find('.barcode').barcode(bill.bill_no, "code128",{showHRI : false});
        $(wrapper).append(el_print_content);
        var config = {
          print_name: "打印运单" + "-" + bill.bill_no,
          top:    "0",
          left:   "0",
          width:  "90mm",
          height: "70mm",
          content: $(wrapper).html(),
          //printer_index : printer_index,
          preview : false
        };
        // $('body').append($(wrapper));
        $.print_html(config);
        $(self).data('printed', true);
      });
    }
  });


  //打印运单条码
  $('.print_barcode').click(function() {
    if ($(this).data('printed')) $.notifyBar({
      html: "请点击[刷新]按钮后再重新打印条码!",
      delay: 3000,
      animationSpeed: "normal",
      cls: 'error'
    });
    else {
      var bill = $(this).data('print');
      var max_barcode_count = parseInt($(this).data('max-barcode-count'));
      var print_template = $(this).data('template');
      var f_seq = 1;
      var t_seq = bill.goods_num;
      if(t_seq > max_barcode_count)
        t_seq = max_barcode_count;
      var ret = $.print_barcode(bill,f_seq,t_seq,print_template);
      if(ret)
        $(this).data('printed', true);
    }
  });

  //增加打印的运单条码
  $('.print_barcode_ex').click(function() {
    if ($(this).data('printed')) $.notifyBar({
      html: "请点击[刷新]按钮后再重新打印条码!",
      delay: 3000,
      animationSpeed: "normal",
      cls: 'error'
    });
    else {
      var bill = $(this).data('print');
      var max_barcode_count = parseInt($(this).data('max-barcode-count'));
      //正常情况下已打印的条码张数
      var printed_seq = bill.goods_num;
      if(printed_seq > max_barcode_count){
        printed_seq = max_barcode_count;
        var ret_input = prompt("请录入要打印的条码数量:",bill.goods_num - printed_seq);
        if(!ret_input) return false;
        try{
          var add_print_count = parseInt(ret_input);
          f_seq = printed_seq + 1;
          t_seq = printed_seq + add_print_count;
          if(t_seq > bill.goods_num)
            t_seq = bill.goods_num;
          var ret = $.print_barcode(bill,f_seq,t_seq);
          if(ret)
            $(this).data('printed', true);
        }
        catch(ex){
          $.notifyBar({
            html: "请输入数字!",
            delay: 3000,
            animationSpeed: "normal",
            cls: 'error'
          });

        }
      }
    }
  });


  //打印单张提货单
  var print_single_th_bill = function(print_template,bill) {
    bill.carrying_fee_total_plus_insured_fee = parseInt(bill.carrying_fee_total) + parseInt(bill.insured_fee);
    bill.th_bill_print_count = parseInt(bill.th_bill_print_count) + 1
    //备注限制为15个字
    bill.note = bill.note.substr(0,15);
    //是否有到货短途标志
    bill.to_short_carrying_fee_flag = "";
    if(parseInt(bill.to_short_carrying_fee) > 0 || parseInt(bill.from_short_carrying_fee) > 0  )
      bill.to_short_carrying_fee_flag = "*";

    //分部电话
    if(typeof(bill.to_org) == 'undefined' || bill.to_org == null){
      bill['to_org']['phone']={};
      bill['to_org']['phone']='';
    }
    if(typeof(bill.transit_org) == 'undefined' || bill.transit_org == null){
      bill['transit_org']={};
      bill['transit_org']['phone']='';
    }
    //应收款=提付运费合计 + 扣手续费 + 提付保险费
    bill.carrying_fee_th_total_plus_k_hand_fee = parseInt(bill.carrying_fee_th_total)+ parseInt(bill.k_hand_fee) + parseInt(bill.insured_fee_th)

    var print_content = nano(print_template,bill);
    var config = {
      print_name: "提货单",
      top: "0",
      left: "0",
      orient : 2,
      width: "95mm",
      height: "210mm",
      content: print_content
    };
    $.print_html(config);
    //打印计数
    var print_counter_url = "/carrying_bills/" + bill.id + "/th_bill_print_counter";
    $.ajax({
      url: print_counter_url,
      type: 'PUT',
    });
  };
  //打印提货票据,check_selected是否检查票据选中状态
  var print_th_bill = function(check_selected){
    var print_template = $(this).data('print-template');
    $.each($('[data-bill]'),function(idx,el_bill){
      var bill = $(el_bill).data('bill');
      if (check_selected && $.inArray(bill.id, $.bill_selector.selected_ids) == - 1)
        ;
      else{
        print_single_th_bill(print_template,bill);
      }
    });
  };

  //提货时,仅仅打印运单
  $('.btn_deliver_only_print,.btn_deliver_re_print').click(function() {
    if ($('[data-bill]').length == 0) $.notifyBar({
      html: "请先查询要提货的运单,然后再进行打印操作.",
      delay: 3000,
      animationSpeed: "normal",
      cls: 'error'
    });
    else {
      print_th_bill.call(this);
    }
  });
  $('.auto_print_bill').click(function() {
    if ($('[data-bill]').length == 0) $.notifyBar({
      html: "请先查询要提货的运单,然后再进行打印操作.",
      delay: 3000,
      animationSpeed: "normal",
      cls: 'error'
    });
    else {
      var print_template = $(this).data("print-template")
      var bill  = $(this).data("bill")
      print_single_th_bill.call(this,print_template,bill);
    }
  });
  //提货打印,触发自动打印事件
  $('.auto_print_bill').trigger('click');

  //货物运输清单打印
  $('.btn_print_th_bill').click(function() {
    if ($('[data-bill]').length == 0) $.notifyBar({
      html: "请先查询要提货的运单,然后再进行打印操作.",
      delay: 3000,
      animationSpeed: "normal",
      cls: 'error'
    });
    else {
      print_th_bill.call(this,true);
    }
  });

  //到货清单打印
  $('.btn_print_th_bills_in_arrive_load_list,.btn_print_th_bills_in_distribution_list,.btn_print_th_bills_in_arrive_outter_transit_load_list').click(function() {
    if ($('[data-bill]').length == 0) $.notifyBar({
      html: "请先查询要打印的运单,然后再进行打印操作.",
      delay: 3000,
      animationSpeed: "normal",
      cls: 'error'
    });
    else {
      print_th_bill.call(this,true);
    }
  });

  //添加服务费后打印提货单
  $('.btn_print_th_bills_in_arrive_load_list_add_service_fee,.btn_print_th_bills_in_distribution_list_add_service_fee').click(function() {
    if ($('[data-bill]').length == 0) $.notifyBar({
      html: "请先查询要打印的运单,然后再进行打印操作.",
      delay: 3000,
      animationSpeed: "normal",
      cls: 'error'
    });
    else {
      print_th_bill_add_service_fee.call(this,true,0.15);
    }
  });

  //打印提货票据,
  //check_selected是否检查票据选中状态
  //service_fee_rate 服务费比例0.15--15%
  var print_th_bill_add_service_fee = function(check_selected,service_fee_rate){
    var print_template = $(this).data('print-template');
    $.each($('[data-bill]'),function(idx,el_bill){
      var bill = $(el_bill).data('bill');
      var clone_bill = $.extend({},bill);
      if (check_selected && $.inArray(bill.id, $.bill_selector.selected_ids) == - 1)
        ;
      else{
        clone_bill.service_fee = 0;
        //只是针对提货付生成服务费
        if(clone_bill.pay_type == 'TH'){
          clone_bill.service_fee = Math.round(clone_bill.carrying_fee*service_fee_rate);
          clone_bill.th_amount = parseInt(clone_bill.th_amount) + clone_bill.service_fee;
          clone_bill.carrying_fee_total= parseInt(clone_bill.carrying_fee_total) + clone_bill.service_fee;
        }
        print_single_th_bill(print_template,clone_bill);
      }
    });
  };




  //货损理赔信息打印
  $('.btn_print_goods_exception').click(function() {
    var table_doc = $('#goods_exception_print').clone();
    table_doc.css({
      tableLayout: 'fixed',
      width: '180mm',
      borderCollapse: 'collapse'
    });
    table_doc.find('tr').css({
      height: '8mm'
    });

    table_doc.find('th,td').css({
      border: 'thin solid #000',
      borderCollapse: 'collapse'
    });

    var config = {
      print_name: "货损理赔信息",
      top: "0",
      left: "0",
      width: "200mm",
      height: "103mm",
      content: table_doc.wrap('<div></div>').parent().html()
    };
    $.print_html(config);
    return false;
  });
  //打印客户转账凭条
  $('.btn_print_pay_info_certificate').click(function() {
    var table_doc = $('.pay_info_certificate');
    //table_doc.find('th,td').css({border : 'thin solid #000',borderCollapse : 'collapse'});
    var config = {
      print_name: "客户转账凭条",
      top: "2mm",
      left: "0",
      width: "188mm",
      height: "92mm",
      content: table_doc.clone().wrap('<div></div>').parent().html()
    };
    $.print_html(config);
    return false;
  });
  //分理处货款收支清单打印
  $('.btn_print_goods_fee_settlement_list').click(function() {
    var table_doc = $('#goods_fee_settlement_list_show').clone();
    table_doc.css({
      tableLayout: 'fixed',
      width: '180mm',
      borderCollapse: 'collapse'
    });
    table_doc.find('tr').css({
      height: '6mm'
    });

    table_doc.find('th,td').css({
      border: 'thin solid #000',
      borderCollapse: 'collapse'
    });

    table_doc.find('tfoot td').css({
      border: 'none'
    });
    var config = {
      print_name: "分理处货款收支清单",
      top: "2mm",
      left: "0",
      width: "210mm",
      height: "160mm",
      content: table_doc.wrap('<div></div>').parent().html()
    };
    $.print_html(config);
    return false;
  });
  //打印凭证
  $('.btn_print_voucher').click(function() {
    var table_doc = $('.accounting_document_wrap').clone();
    var set_style = function(table_doc){
      table_doc.find('.title').css({'font-size' : '18px'});
      //设置打印样式
      table_doc.find('table').css({'border-collapse' : 'collapse','table-layout' : 'fixed','width' : '190mm'});
      table_doc.find('.header td,.header th').css({'border' : '1px solid #000'});
      table_doc.find('tbody').css({'border' : '2px solid #000'});
      table_doc.find('tbody td').css({
        'font-size' : '13px',
        'border' : '1px solid #000'
      });
      //金额分割
      table_doc.find('.seprate').css({'border-right' : '2px solid #000'});
      //数字字体变小
      table_doc.find('.header .num').css({'font-size' : '10px'});
      //设置宽度
      table_doc.find('td').css({'height' : '5mm'});
      table_doc.find('.num').css({'width' : '4mm'});
      //table_doc.find('.seprate').css({'width' : '4mm'});
      table_doc.find('.description').css({'width' : '30mm','overflow' : 'hidden'});
      table_doc.find('.ge_led,.sub_led').css({'width' : '22mm','overflow' : 'hidden'});
    };
    set_style(table_doc);
    var config = {
      print_name: "会计凭证",
      preview : true,
      orient : 2,
      top: "2mm",
      left: "3mm",
      width: "95mm",
      height: "210mm",
      content: table_doc.html()
    };
    $.print_html(config);
    //打印附表
    var detail_table = $('.accounting_document_detail_wrap').clone();
    if(detail_table.length > 0){

      var set_style = function(table_doc){
        table_doc.find('.title').css({'font-size' : '18px'});
        //设置打印样式
        table_doc.find('table').css({'border-collapse' : 'collapse',
                                    //'table-layout' : 'fixed',
                                    //'width' : '90mm',
                                    'border' : '1px solid #000;'
        });

        table_doc.find('table.title_header').css({'border' : 'none',
                                                 'width' : '90mm',
                                                 'table-layout' : 'fixed'
        });

        table_doc.find('table.title_header .org_name').css({'width' : '35mm'});
        //table_doc.find('table.title_header .page_num').css({'width' : '10mm'});
        table_doc.find('table.title_header .date').css({'width' : '35mm'});
        //table_doc.find('.item_header').css({'width' : '10mm'});
        //table_doc.find('.cr_header').css({'width' : '40mm'});
        //table_doc.find('.dr_header').css({'width' : '40mm'});
        table_doc.find('.header td,.header th').css({'border' : '1px solid #000'});
        table_doc.find('tbody').css({'border' : '2px solid #000'});
        table_doc.find('.item,tbody td,tfoot td').css({
          'font-size' : '10px',
          'border' : '1px solid #000',
          'height' : '5mm'
        });
        //金额分割
        table_doc.find('.seprate').css({'border-right' : '2px solid #000'});
        //数字字体变小
        table_doc.find('.header .num').css({'font-size' : '10px'});
        //显示隐藏的header
        table_doc.find('.title_header,.header').show();
      };
      set_style(detail_table);
      var config_detail = {
        print_name: "会计凭证附表",
        preview : true,
        //orient : 2,  //横向打印
        top: "2mm",
        left: "0",
        width: "97mm",
        height: "210mm",
        content: detail_table.html()
      };
      if(window.confirm("需要打印[附表]吗?"))
        $.print_html(config_detail);
    }
    return false;
  });
});
