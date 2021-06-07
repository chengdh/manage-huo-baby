// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(function($) {
	//扩展jQuery function
	$.extend({
		/*
           功能：将货币数字（阿拉伯数字）(小写)转化成中文(大写）
           参数：Num为字符型,小数点之后保留两位,例：Arabia_to_Chinese("1234.06")
           说明：
           1.目前本转换仅支持到 拾亿（元） 位，金额单位为元，不能为万元，最小单位为分
           2.不支持负数
           */
		num2chinese: function(Num) {
			for (i = Num.length - 1; i >= 0; i--) {
				Num = Num.replace(",", "") //替换tomoney()中的“,”
				Num = Num.replace(" ", "") //替换tomoney()中的空格
			}

			Num = Num.replace("￥", "") //替换掉可能出现的￥字符
			if (isNaN(Num)) {
				//验证输入的字符是否为数字
				alert("请检查小写金额是否正确");
				return;
			}
			//---字符处理完毕，开始转换，转换采用前后两部分分别转换---//
			part = String(Num).split(".");
			newchar = "";
			//小数点前进行转化
			for (i = part[0].length - 1; i >= 0; i--) {
				if (part[0].length > 10) {
					alert("位数过大，无法计算");
					return "";
				} //若数量超过拾亿单位，提示
				tmpnewchar = ""
				perchar = part[0].charAt(i);
				switch (perchar) {
				case "0":
					tmpnewchar = "零" + tmpnewchar;
					break;
				case "1":
					tmpnewchar = "壹" + tmpnewchar;
					break;
				case "2":
					tmpnewchar = "贰" + tmpnewchar;
					break;
				case "3":
					tmpnewchar = "叁" + tmpnewchar;
					break;
				case "4":
					tmpnewchar = "肆" + tmpnewchar;
					break;
				case "5":
					tmpnewchar = "伍" + tmpnewchar;
					break;
				case "6":
					tmpnewchar = "陆" + tmpnewchar;
					break;
				case "7":
					tmpnewchar = "柒" + tmpnewchar;
					break;
				case "8":
					tmpnewchar = "捌" + tmpnewchar;
					break;
				case "9":
					tmpnewchar = "玖" + tmpnewchar;
					break;
				}
				switch (part[0].length - i - 1) {
				case 0:
					tmpnewchar = tmpnewchar + "元";
					break;
				case 1:
					if (perchar != 0) tmpnewchar = tmpnewchar + "拾";
					break;
				case 2:
					if (perchar != 0) tmpnewchar = tmpnewchar + "佰";
					break;
				case 3:
					if (perchar != 0) tmpnewchar = tmpnewchar + "仟";
					break;
				case 4:
					tmpnewchar = tmpnewchar + "万";
					break;
				case 5:
					if (perchar != 0) tmpnewchar = tmpnewchar + "拾";
					break;
				case 6:
					if (perchar != 0) tmpnewchar = tmpnewchar + "佰";
					break;
				case 7:
					if (perchar != 0) tmpnewchar = tmpnewchar + "仟";
					break;
				case 8:
					tmpnewchar = tmpnewchar + "亿";
					break;
				case 9:
					tmpnewchar = tmpnewchar + "拾";
					break;
				}
				newchar = tmpnewchar + newchar;
			}
			//小数点之后进行转化
			if (Num.indexOf(".") != - 1) {
				if (part[1].length > 2) {
					alert("小数点之后只能保留两位,系统将自动截段");
					part[1] = part[1].substr(0, 2)
				}
				for (i = 0; i < part[1].length; i++) {
					tmpnewchar = ""
					perchar = part[1].charAt(i)
					switch (perchar) {
					case "0":
						tmpnewchar = "零" + tmpnewchar;
						break;
					case "1":
						tmpnewchar = "壹" + tmpnewchar;
						break;
					case "2":
						tmpnewchar = "贰" + tmpnewchar;
						break;
					case "3":
						tmpnewchar = "叁" + tmpnewchar;
						break;
					case "4":
						tmpnewchar = "肆" + tmpnewchar;
						break;
					case "5":
						tmpnewchar = "伍" + tmpnewchar;
						break;
					case "6":
						tmpnewchar = "陆" + tmpnewchar;
						break;
					case "7":
						tmpnewchar = "柒" + tmpnewchar;
						break;
					case "8":
						tmpnewchar = "捌" + tmpnewchar;
						break;
					case "9":
						tmpnewchar = "玖" + tmpnewchar;
						break;
					}
					if (i == 0) tmpnewchar = tmpnewchar + "角";
					if (i == 1) tmpnewchar = tmpnewchar + "分";
					newchar = newchar + tmpnewchar;
				}
			}
			//替换所有无用汉字
			while (newchar.search("零零") != - 1)
			newchar = newchar.replace("零零", "零");
			newchar = newchar.replace("零亿", "亿");
			newchar = newchar.replace("亿万", "亿");
			newchar = newchar.replace("零万", "万");
			newchar = newchar.replace("零元", "元");
			newchar = newchar.replace("零角", "");
			newchar = newchar.replace("零分", "");

			if (newchar.charAt(newchar.length - 1) == "元" || newchar.charAt(newchar.length - 1) == "角") newchar = newchar + "整"
			return newchar;
		},

    update_query_string_parameter : function(uri, key, value) {
      var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
      var separator = uri.indexOf('?') !== -1 ? "&" : "?";
      if (uri.match(re)) {
        return uri.replace(re, '$1' + key + "=" + value + '$2');
      }
      else {
        return uri + separator + key + "=" + value;
      }
    },
		//得到当前controller的显示或隐藏字段字符串
		show_or_hidden_fields_obj: function() {
			var obj = $('#global_data').data('show_or_hidden_fields');
			return obj;
		} (),

		//导出数据到excel, for none ie browser
		export_excel: function() {
			var uri = 'data:application/vnd.ms-excel;base64,',
			template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>',
			base64 = function(s) {
				return window.btoa(unescape(encodeURIComponent(s)))
			},
			format = function(s, c) {
				return s.replace(/{(\w+)}/g, function(m, p) {
					return c[p];
				})
			};
			return function(table_str, func_set_style) {
				try {
					if (func_set_style) func_set_style($(table_str));
				}
				catch(ex) {}
				var ctx = {
					worksheet: name || 'Worksheet',
					table: table_str
				};
				data = uri + base64(format(template, ctx));
				window.location.href = data;
			}
		} (),
		//导出excel并压缩后下载
		export_excel_zip: function() {
			return function(table_str) {
				var zip_data = table_str;
				var zip = new JSZip();
				zip.file("bills.xls", zip_data);
				var content = zip.generate({
					compression: "DEFLATE"
				});
				location.href = "data:application/zip;base64," + content;
			}
		} (),
		//模拟mouseclick
		fireClick: function(el) {
			if (!el) return;
			if (document.dispatchEvent) { // W3C
				var oEvent = document.createEvent("MouseEvents");
				oEvent.initMouseEvent("click", true, true, window, 1, 1, 1, 1, 1, false, false, false, false, 0, el);
				el.dispatchEvent(oEvent);
			}
			else if (document.fireEvent) { // IE
				el.click();
			}
		}
	});
	//初始化区域选择
	$(".select_org[name!='return_bill[to_org_id]']").livequery(function() {
		$(this).ufd();
	});

	$(".select_org[name='return_bill[to_org_id]'],.carrying_bill_edit .select_org").livequery(function() {
		$(this).ufd('destroy');
		$(this).select_combobox();
	});

  $(".select_areas").livequery(function(){
    $(this).ufd();
  });

	//导出excel按钮绑定
	$('.btn_export_excel').click(function() {
		var url = $(this).attr('href');
		$.get(url, null, null, 'script');
		return false;
	});


	//双击某条记录打开详细信息
	//tr[data-dblclick]
	$('#bills_table,table.table[id$="index_table"]').livequery('dblclick', function(evt) {
		var target_el = $(evt.target).parent('tr');
		if (target_el.attr('data-dblclick')) {
			var el_anchor = $(target_el).find('a.show_link');
			if ($(el_anchor).hasClass('popup-box')) {
				$(el_anchor).fancybox({
					ajax: {
						dataType: 'html'
					}
				});
				$.fireClick($(el_anchor)[0]);
			}
			else {
				window.location = $(el_anchor).attr('href');
				$.fancybox.showActivity();
			}
		}

	}).live('click', function(evt) { //单击某条记录选中
		var target_el = $(evt.target).parent('tr');
		if (target_el.attr('data-dblclick')) {
			$('tr[data-dblclick]').removeClass('cur_select');
			$(target_el).addClass('cur_select');
		}

	});

	$('.btn_edit').click(function() {
		var cur_select = $('tr[data-dblclick].cur_select .edit_link');
		if (cur_select.length == 0) {
			$.notifyBar({
				html: "请先选择要编辑的数据!",
				delay: 3000,
				animationSpeed: "normal",
				cls: 'error'
			});
			return false;
		}

		if (cur_select.length > 0) $(this).attr('href', $(cur_select[0]).attr('href'));
		if ($(this).attr('href') == '') return false;

	});
	$('.btn_delete').click(function() {
		var cur_select = $('tr[data-dblclick].cur_select .delete_link');
		if (cur_select.length == 0) {
			$.notifyBar({
				html: "请先选择要删除的数据!",
				delay: 3000,
				animationSpeed: "normal",
				cls: 'error'
			});
			return false;
		}

		if (cur_select.length > 0) $(this).attr('href', $(cur_select[0]).attr('href'));
		if ($(this).attr('href') == '') return false;

	});
	//根据客户编号查询客户信息
	var search_customer_by_code = function() {
		var code = $(this).val();
		if (code == "") return;
		$.get('/vips', {
			"search[code_eq]": code,
			"search[is_active_eq]": 1,
			"search[vip_state_eq]": 'audited',
			"in_wich": 'carrying_bill_form'
		},
		null, 'script');

	};
	$('form.computer_bill #customer_code,form.transit_bill #customer_code,form.auto_calculate_computer_bill #customer_code,form.inner_transit_bill #customer_code').live('change', search_customer_by_code);

	//绑定所有日期选择框
	$.datepicker.setDefaults({
		dateFormat: 'yy-mm-dd'
	});
	$.datepicker.setDefaults($.datepicker.regional['zh_CN']);
	$('.datepicker').livequery(function() {
		$(this).attr('readonly', true);
		$(this).datepicker();
	});

	//初始化左侧菜单树
	var cookieName = 'il_cur_menu_group';
	var get_current_menu_group = function() {
		var cookie_menu = $.cookies.get(cookieName);
		return cookie_menu;
	};

	/*当前menu_group设置*/
	var cur_menu_group = get_current_menu_group();
	if (cur_menu_group) $('#' + cur_menu_group).next('.navigation:first').show();
	/*menu_bar的点击事件*/
	$('#menu_bar .group_name').click(function() {
		var cur_el = $(this).next('.navigation:first')[0];
		$('#menu_bar .navigation').each(function(index, el) {
			if (el == cur_el) $(el).toggle();
			else $(el).hide();
		});
		$.cookies.set(cookieName, $(this).attr('id'));
	});

	$('#menu_bar .navigation a').bind('click', function() {
		$.fancybox.showActivity();
	});

	$('.fancybox').livequery(function() {
		$(this).fancybox({
			scrolling: 'no',
			padding: 20,
			ajax: {
				dataType: 'html'
			}
		});
	});

	//初始化tip
	$('.tipsy').livequery(function() {
		$('.tipsy').tipSwift({
			gravity: $.tipSwift.gravity.autoWE,
			plugins: [
			$.tipSwift.plugins.tip({
				offset: 5,
				gravity: 's',
				opacity: 0.6,
				showEffect: $.tipSwift.effects.fadeIn,
				hideEffect: $.tipSwift.effects.fadeOut
			})]
		});

	});
	$.blockUI.defaults.message = null;
	$.blockUI.defaults.overlayCSS.opacity = 0.2;
	//运单列表表头点击事件
	$('#table_wrap tr.table-header th a[href!="#"],#table_wrap .pagination a[href!="#"]').live('click', function() {
		$.getScript(this.href);
		return false;
	});
	$('.bill_selector').livequery(function() {
		$(this).form_with_select_bills();
	});

	$(document).ajaxStart(function() {
		$.blockUI();
		$.fancybox.showActivity();
	}).ajaxStop(function() {
		$.unblockUI();
		$.fancybox.hideActivity();
	});
	//对需要长时间处理的操作,显示blockUI
	$('.btn_process_handle').bind('click', function() {
		$.blockUI();
		$.fancybox.showActivity();
	});

	//首页运单查询
	//去除所有绑定
	$('#home-search-box').watermark('录入运单号/货号查询').keydown(function(e) {
		if (e.keyCode == 13) {
      var val = $(this).val();
      //测试输入的数据是否为空
      if(/^[\s]*$/.test(val)) return false;
			$('#home-search-form').trigger('submit');
		}
	});
	//search box
	$('.search_box').livequery(function() {
    var water_mark = "录入运单编号查询";
    if($(this).hasClass('delivery_search_box'))
      water_mark = "录入运单号/发货人手机/姓名查询";
		$(this).watermark(water_mark, {
			userNative: false
		}).focus(function() {
			$(this).select();
		}).keypress(function(e) {
      var self = this;
			if (e.keyCode == 13) {
				if ($(this).val() == "") return;
				params = $(this).data('params');
        $.extend(params,{
          "search[bill_no_eq]" : "",
          "search[to_customer_phone_or_to_customer_mobile_ew]": "",
          "search[bill_no_or_to_customer_phone_or_to_customer_mobile_or_to_customer_name_like]": "",
					"search[from_org_id_eq]": "",
					"search[to_org_id_eq]": "",
					"search[transit_org_id_eq]": "",
					"search[transit_org_id_or_to_org_id_eq]": "",
					"search[from_org_id_or_to_org_id_eq]": ""
        });
        //FIXME 提货,添加按照收货人电话、手机、姓名查询
        if($(this).hasClass('delivery_search_box') || $(this).hasClass('from_short_fee_search_box') ){
          var input_val = $(this).val();
          //输入的是票号或其他
          if(input_val.length == 7 || input_val.length == 8){
            $.extend(params, {
              "search[bill_no_eq]": input_val
            });
          }
          else if(input_val.length == 4 || input_val.length == 11 ){
            $.extend(params, {
              "search[to_customer_phone_or_to_customer_mobile_ew]": input_val
            });
          }
          else{
            $.extend(params, {
              "search[bill_no_or_to_customer_phone_or_to_customer_mobile_or_to_customer_name_like]": input_val
            });
          }
        }
        else{
          $.extend(params, {
            "search[bill_no_eq]": $(this).val()
          });
        }
				//添加发货站或到货站id
				if ($('#from_org_id').length > 0) $.extend(params, {
					"search[from_org_id_eq]": $('#from_org_id').val()
				});
				if ($('#to_org_id').length > 0) $.extend(params, {
					"search[to_org_id_eq]": $('#to_org_id').val()
				});
				if ($('#transit_org_id').length > 0) $.extend(params, {
					"search[transit_org_id_eq]": $('#transit_org_id').val()
				});

	      if ($('#transit_org_id_or_to_org_id').length > 0) $.extend(params, {
					"search[transit_org_id_or_to_org_id_eq]": $('#transit_org_id_or_to_org_id').val()
				});

				if ($('#from_org_id_or_to_org_id').length > 0) $.extend(params, {
					"search[from_org_id_or_to_org_id_eq]": $('#from_org_id_or_to_org_id').val()
				});

				$.get('/carrying_bills', params, function(){$('.search_box').trigger('ajax:complete');}, 'script');
				$(this).select();
			}
		})
	});

	$('#transit_info_form, \
    #transit_deliver_info_form,#short_fee_info_form,#goods_exception_form, \
    #send_list_form,#send_list_post_form,#adjust_fee_info_form,#adjust_goods_fee_info_form, \
    #in_stock_bill_form,#debt_bill_form,#customer_payment_info_form').livequery(
    function() {
		$(this).bind('ajax:before', function() {
			var bill_els = $('[data-bill]');
			var bill_ids = [];
			//中转提货相关费用
			//获取中转相关费用array
			var get_transit_edit_fields_val = function(el_name) {
				var ret_val = [];

				$('[name^="' + el_name + '"]').each(function() {
					ret_val.push($(this).val());

				});
				return ret_val;
			};

			if (bill_els.length == 0) {
				$.notifyBar({
					html: "未查找到任何运单,请先查询要处理的运单",
					delay: 3000,
					animationSpeed: "normal",
					cls: 'error'
				});
				return false;
			}
			else {
				bill_els.each(function() {
					var bill_id = $(this).data('bill').id;
					bill_ids.push(bill_id);
				});
				$(this).data('params', {
					"bill_ids[]": bill_ids,
					"transit_carrying_fee_edit[]": get_transit_edit_fields_val('transit_carrying_fee_edit'),
					"transit_hand_fee_edit[]": get_transit_edit_fields_val('transit_hand_fee_edit'),
					"transit_to_phone_edit[]": get_transit_edit_fields_val('transit_to_phone_edit'),
					"transit_bill_no_edit[]": get_transit_edit_fields_val('transit_bill_no_edit')
				});
			}
			return true;
		})
	});

  //运单暂扣或挂失时,需要提示
  $('.pay_info_list').on('tr_changed',function(){
		var el_tr = $('[data-bill]:first');
    if(el_tr.length > 0){
      var bill = el_tr.data('bill');
      //挂失
      if(bill.additional_state == 'lossed'){
        window.alert("该运单已挂失,请出示挂失单据!" +"[" + bill.additional_note + "]");
      }
      //暂扣
      if(bill.additional_state == 'detained'){
        window.alert("该运单已暂扣,请解除暂扣后再进行提款操作!")
        el_tr.parents('tr').remove();
        el_tr.remove();
        $('#bills_table_body').trigger('tr_changed');
      }
    }
  });
	//对票据进行操作时,计算合计值
	var cal_sum = function() {
		var sum_info = {};
		$.each($.bill_selector.sum_info_key_array, function(unused, key) {
			sum_info[key] = 0;
		});
		$('#bills_table_body tr[data-bill]').each(function() {
			var the_bill = $(this).data('bill');
			$.each($.bill_selector.sum_info_key_array, function(unused, key) {
				if (key == 'sum_count') sum_info[key] += 1;
				else sum_info[key] += parseFloat(the_bill[key.slice(4)]);
			});
		});

		$.each($.bill_selector.sum_info_key_array, function(unused, key) {
			$('#' + key).html(sum_info[key]);
		});
		//计算可修改字段
		var cal_edit_field_sum = function(field_class) {
			var sum = 0;
			$("tr.bill_cal_sum " + "." + field_class + " input").each(function() {
				var val = parseFloat($(this).val());
				sum += val;
			});
			$("#sum_" + field_class).html(sum);
		};
		var edit_fields = ["transit_carrying_fee_edit", "transit_hand_fee_edit"]
		$.each(edit_fields, function(index, value) {
			cal_edit_field_sum(value)
		});

	};
	//绑定明细变化事件
	//货物中转及中转提货时,进行合计
  //re_cal_sum是为了重新计算而不触发tr_changed事件,因为有时可能会引起死循环
	$('#bills_table_body').bind('tr_changed', cal_sum).bind('re_cal_sum',cal_sum).bind('change', function(evt) {
		var target_el = $(evt.target).parent('td');

		if (target_el && (target_el.hasClass('transit_carrying_fee_edit') || target_el.hasClass('transit_hand_fee_edit')))
		//触发运单明细改变事件
		$('#bills_table_body').trigger('tr_changed');
	});

	/*
//客户提款结算清单
//实领金额变化时,更新余额
var cal_rest_fee = function() {
var amount_fee = parseFloat($('#post_info_amount_fee').val());
var sum_pay_fee = parseFloat($('#sum_pay_fee').val());
var rest_fee = amount_fee - sum_pay_fee;
$('#sum_rest_fee').val(rest_fee);

};
*/

	//送货清单,查询运单后,自动清除已核销或正在送货中的运单记录
	$('#send_list_form_after_wrap tr[data-bill]').livequery(function() {
		var bill = $(this).data('bill');
		//移除已送货或正在送货中的运单
		if (bill.send_state == 'posted' || bill.send_state == 'sended') {
			$.notifyBar({
				html: "该运单已送货或正在送货中!",
				delay: 3000,
				animationSpeed: "normal",
				cls: 'error'
			});
			$(this).remove();

		}

	});

	//送货员未交票统计
	$('#btn_send_list_line_query').bind('ajax:before', function() {
		var params = {
			"search[send_list_line_send_list_sender_id_eq]": $('#sender_id').val(),
			"search[send_list_line_state_eq]": "sended",
			"search[to_org_id_eq]": $('#to_org_id').val()
		};
		//运单列表显示的字段
		$.extend(params, $.show_or_hidden_fields_obj);
		$(this).data('params', params);

	});
	//帐目盘点登记表,自动计算合计功能
	$('#journal_form').change(function() {
		var settled_no_rebate_fee = parseFloat($('#journal_settled_no_rebate_fee').val());
		var deliveried_no_settled_fee = parseFloat($('#journal_deliveried_no_settled_fee').val());
		var input_fee_1 = parseFloat($('#journal_input_fee_1').val());
		var input_fee_2 = parseFloat($('#journal_input_fee_2').val());
		var input_fee_3 = parseFloat($('#journal_input_fee_3').val());
		var journal_sum_1 = settled_no_rebate_fee + deliveried_no_settled_fee + input_fee_1 + input_fee_2 + input_fee_3;
		$('#journal_sum_1').html(journal_sum_1);
		var cash = parseFloat($('#journal_cash').val());
		var deposits = parseFloat($('#journal_deposits').val());
		var goods_fee = parseFloat($('#journal_goods_fee').val());
		var short_fee = parseFloat($('#journal_short_fee').val());
		var other_fee = parseFloat($('#journal_other_fee').val());
		var journal_sum_2 = cash + deposits + goods_fee + short_fee + other_fee;
		$('#journal_sum_2').html(journal_sum_2);
		//客户欠款
		var current_debt = parseFloat($('#journal_current_debt').val());
		var current_debt_2_3 = parseFloat($('#journal_current_debt_2_3').val());
		var current_debt_4_5 = parseFloat($('#journal_current_debt_4_5').val());
		var current_debt_ge_6 = parseFloat($('#journal_current_debt_ge_6').val());
		var journal_sum_4 = current_debt + current_debt_2_3 + current_debt_4_5 + current_debt_ge_6;
		$('#journal_sum_4').html(journal_sum_4);

	});

	//vip统计列表
	$('#imported_customer_org_id').change(function() {
		$.get('/imported_customers', {
			"search[org_id_eq]": $(this).val()
		},
		function() {
			$('.tabs a').removeClass('here');
			$('.tabs a').first().addClass('here');
		},
		'script');
	});
	$('#imported_customers_tab a').bind('ajax:before', function() {
		$(this).data('params', {
			"search[org_id_eq]": $('#imported_customer_org_id').val()
		});

	});
	$('.tabs a').click(function() {
		$('.tabs a').removeClass('here');
		$(this).addClass('here');

	});

  //凭证切换
  $('.tabs .tab_accounting_document').click(function(){
    $('.accounting_document_wrap').show();
    $('.accounting_document_detail_wrap').hide();
  });
  $('.tabs .tab_accounting_document_detail').click(function(){
    $('.accounting_document_wrap').hide();
    $('.accounting_document_detail_wrap').show();
  });

  //自动获取明细信息
	$('[data-detailUrl]').livequery(function() {
		var url = $(this).data('detailurl');
		var params = $(this).data('params');
		$.get(url, params, null, 'script');
	});

	//根据参数显示或隐藏字段
	//render shared/carrying_bills/table时使用
	$('[data-showfields]').livequery(function() {
		$($(this).data('showfields')).show();

	});
	$('[data-hidefields]').livequery(function() {
		$($(this).data('hidefields')).hide();
	});

	//修改org的录单限制时间
	$('form.only_edit_lock_time').livequery(function() {
		$('#org_form :input[type="text"],#org_form :input[type="checkbox"],#org_form select').attr('readonly', true);
		$('#org_form [name*="lock_input_time"]').attr('readonly', false);
	});
	//修改readonly底色
	$('[readonly]').livequery(function() {
		$(this).css({
			backgroundColor: '#E5E5E5'
		});
	});

	//日营业额统计,月营业额统计/代收货款收入-支出统计导出
	$('a[data-table]').click(function() {
		var table_doc = $($(this).data('table')).clone();

		table_doc.find('th,td').css({
			border: 'thin solid #000'
		});
		var set_style = function(work_sheet) {
			work_sheet.Columns.ColumnWidth = 7;
			work_sheet.Columns('A:A').ColumnWidth = 5;

		};
		$.export_excel(table_doc.clone().wrap('<div></div>').parent().html(), set_style);
	});
  //货物滞留清单-导出
  $('.btn_inventory_export').on('click',function(){
		var table_doc = $('.inventory_table').clone();
		table_doc.find('th,td').css({
			border: 'thin solid #000'
		});
		var set_style = function(work_sheet) {
			work_sheet.Columns.ColumnWidth = 7;
			work_sheet.Columns('A:A').ColumnWidth = 5;

		};
		$.export_excel(table_doc.wrap('<div></div>').parent().html(), set_style);
  });

	//form 自动获取焦点
	$('.inner form').livequery(function() {
		var the_form = $(this);
		if (the_form.hasClass('computer_bill') || the_form.hasClass('transit_bill') || the_form.hasClass('return_bill') || the_form.hasClass('auto_calculate_computer_bill')) {

			//机打运单,默认焦点定位到到货地
			//$('#select_org_input_to_org_id').focus();
			$('#ufd-to_org_id').focus();
			$('#area_id').focus();
		}
		else $('.inner form input:not([readonly])').not('input[type="hidden"]').first().focus();

	});

	//快捷键设置
	// $(document).bind('keydown', 'n', function() {
	// 	$.fireClick($('.btn_new')[0]);
	// }).bind('keydown', 's', function() {
	// 	$.fireClick($('.btn_save')[0]);
	// }).bind('keydown', 'e', function() {
	// 	$.fireClick($('.btn_modify')[0]);
	// }).bind('keydown', 'f', function() {
	// 	$.fireClick($('.btn_search')[0]);
	// }).bind('keydown', 'd', function() {
	// 	$.fireClick($('.btn_destroy')[0]);
	// }).bind('keydown', 'x', function() {
	// 	$.fireClick($('.btn_export_excel')[0]);
	// }).bind('keydown', 'l', function() {
	// 	$.fireClick($('.btn_index')[0]);
	// }).bind('keydown', 'p', function() {
	// 	$.fireClick($('.btn_print')[0]);
	// }).bind('keydown', 'alt+t', function() {
	// 	//任何情况下,点击alt+t打开运单录入
	// 	window.location = "/computer_bills/new";
	// }).bind('keydown', 'ctrl+z', function() {
	// 	//任何情况下，可点击ctrl_z打开运单查询界面
	// 	$.fireClick(document.getElementById('btn_advanced_search'));
	// });

	//设置notify cookie
	//如果cookie中找到了对应的notify_id，则不显示
	$('[data-notify]').livequery(function() {
		var notify = $(this).data('notify');
		if ($.cookies.get('il_notify_' + notify.id)) $('#notify-bar').hide();
		else $('#notify-bar').show();
	});
    /*
	//关闭提醒
	$('span.notify-close').click(function() {
		var notify = $('[data-notify]').data('notify');
		$.cookies.set('il_notify_' + notify.id, notify.notify_text);
		$('#notify-bar').hide();
	});
    */
	//日营业额统计图单击选中
	$('#rpt_turnover,#rpt_turnover_by_from_org').click(function(evt) { //单击某条记录选中
		var target_el = $(evt.target).parent('tr');
		$(this).find('td').css({
			backgroundColor: '#FFF',
			color: '#000',
			fontSize: '1em',
			fontWeight: 'normal'
		});
		$(target_el).find('td').css({
			backgroundColor: '#7A97B7',
			color: '#FFF',
			fontSize: '1.2em',
			fontWeight: 'bold'
		});
	});
	//运费货款统计,现金/转账条件查询
	$('#simple_search_from_customer_id_not_null,#simple_search_from_customer_id_null').click(function() {
		if ($(this).attr('checked')) $('#simple_search_goods_fee_gt').val('0');
		else $('#simple_search_goods_fee_gt').val('');

	});
	//分理处货款收支清单,录入变化时自动计算
	$('#goods_fee_settlement_list_amount_hand_fee,#goods_fee_settlement_list_amount_k_carrying_fee,#goods_fee_settlement_list_amount_k_carrying_fee,#goods_fee_settlement_list_amount_k_from_short_carrying_fee,#goods_fee_settlement_list_amount_k_to_short_carrying_fee,#goods_fee_settlement_list_amount_k_insured_fee,#goods_fee_settlement_list_amount_bills,#goods_fee_settlement_list_amount_goods_fee,#goods_fee_settlement_list_amount_fee').change(function() {

		var amount_hand_fee_auto = 0;
		var amount_goods_fee_auto = 0;
		var amount_k_carrying_fee_auto = 0;
		var amount_k_insured_fee_auto = 0;
		var amount_k_from_short_carrying_fee_auto = 0;
		var amount_k_to_short_carrying_fee_auto = 0;

		var amount_bills_auto = 0;
		var amount_hand_fee = 0;
		var amount_goods_fee = 0;
		var amount_k_carrying_fee = 0;
		var amount_k_insured_fee = 0;
		var amount_k_from_short_carrying_fee = 0;
		var amount_k_to_short_carrying_fee = 0;
		var amount_bills = 0;
		var amount_fee = 0;
		var sum_bills = 0;
		var sum_income_fee = 0;
		var sum_spending_fee = 0;
		var sum_rest_fee = 0;
		amount_hand_fee_auto = parseFloat($('#amount_hand_fee_auto').text());
		amount_goods_fee_auto = parseFloat($('#amount_goods_fee_auto').text());
		amount_k_carrying_fee_auto = parseFloat($('#amount_k_carrying_fee_auto').text());
		amount_k_insured_fee_auto = parseFloat($('#amount_k_insured_fee_auto').text());
		amount_k_from_short_carrying_fee_auto = parseFloat($('#amount_k_from_short_carrying_fee_auto').text());
		amount_k_to_short_carrying_fee_auto = parseFloat($('#amount_k_to_short_carrying_fee_auto').text());
		amount_bills_auto = parseFloat($('#amount_bills_auto').text());
		amount_hand_fee = parseFloat($('#goods_fee_settlement_list_amount_hand_fee').val());
		amount_goods_fee = parseFloat($('#goods_fee_settlement_list_amount_goods_fee').val());
		amount_k_carrying_fee = parseFloat($('#goods_fee_settlement_list_amount_k_carrying_fee').val());
		amount_k_from_short_carrying_fee = parseFloat($('#goods_fee_settlement_list_amount_k_from_short_carrying_fee').val());
		amount_k_to_short_carrying_fee = parseFloat($('#goods_fee_settlement_list_amount_k_to_short_carrying_fee').val());
		amount_k_insured_fee = parseFloat($('#goods_fee_settlement_list_amount_k_insured_fee').val());
		amount_bills = parseFloat($('#goods_fee_settlement_list_amount_bills').val());
		amount_fee = parseFloat($('#goods_fee_settlement_list_amount_fee').val());

		sum_bills = amount_bills + amount_bills_auto;
		sum_income_fee = amount_hand_fee + amount_hand_fee_auto + amount_k_carrying_fee + amount_k_carrying_fee_auto + amount_k_insured_fee + amount_k_insured_fee_auto + amount_k_from_short_carrying_fee + amount_k_from_short_carrying_fee_auto + amount_k_to_short_carrying_fee + amount_k_to_short_carrying_fee_auto + amount_fee;
		sum_spending_fee = amount_goods_fee + amount_goods_fee_auto;
		sum_rest_fee = sum_income_fee - sum_spending_fee;
		$('#sum_bills').html(sum_bills);
		$('#sum_income_fee').html(sum_income_fee);
		$('#sum_income_fee_chinese').html($.num2chinese(sum_income_fee.toString()));
		$('#sum_spending_fee').html(sum_spending_fee);
		$('#sum_spending_fee_chinese').html($.num2chinese(sum_spending_fee.toString()));
		$('#sum_rest_fee').html(sum_rest_fee);
		$('#sum_rest_fee_chinese').html($.num2chinese(sum_rest_fee.toString()));
	});
	// 实际装车清单,全选 / 不选
	$('#btn_act_load_list_line_select_all').live('click', function() {
		$('.act_load_list_line_selector').attr('checked', true)
	});
	$('#btn_act_load_list_line_unselect_all').live('click', function() {
		$('.act_load_list_line_selector').attr('checked', false)
	});

	//到货清单通知的全选/不选
	$('#btn_notice_line_select_all').live('click', function() {
		$('.notice_line_selector').attr('checked', true)
	});
	$('#btn_notice_line_unselect_all').live('click', function() {
		$('.notice_line_selector').attr('checked', false)
	});

	//多运单查询
	$('#txt_multi_bills_search').watermark('可用逗号分割多个运单号进行查询，比如:0000400,0000401,0000402')
	$('#btn_multi_bills_search').click(function() {
		var bills_string = $('#txt_multi_bills_search').val();
		var bill_nos = bills_string.match(/\d{7,8}/g)
		// var bill_nos = bills_string.split(",")
		if (bill_nos) {
			//将解析出的运单号加入到form中去
			$.each(bill_nos, function(index, bill_no) {
				var hidden_field = '<input name="search[bill_no_in][]" type="hidden" value="' + bill_no + '" />';
				$('#multi_bills_search_form').append(hidden_field);
			});
			$('#multi_bills_search_form').submit();
		}
	});

	//到货清单导出短信文本
	$('#btn_export_sms_txt').click(function() {
		if ($.bill_selector.selected_ids.length == 0) {
			$.notifyBar({
				html: "请先选择要通知的运单!",
				delay: 3000,
				animationSpeed: "normal",
				cls: 'error'
			});
			return false;
		}

		$('#export_sms_form input').remove('[type|="hidden"][name|="bill_ids[]"]');
		//附加选中的运单id到form中
		$.each($.bill_selector.selected_ids, function(index, value) {
			var hidden_field = $("<input type='hidden' name='bill_ids[]' value='" + value + "' />");
			$('#export_sms_form').append(hidden_field);

		});
		$('#export_sms_form').trigger('submit');
	});

	//未提货报表选择单据
	//FIXME 支持分页选择
	//jquery中checkbox click事件的问题,如下所述
	//http://stackoverflow.com/questions/7668826/jquery-triggerclick-not-firing-click-event-on-checkbox
	$('#btn_select_notice_failed').livequery('click', function() {
		$($.bill_selector).trigger('set_all', [false]);
		$('.notice_is_failed .cbx_select_bill [data-bill]').trigger('click');
	});
	$('#btn_select_notice_draft').livequery('click', function() {
		$($.bill_selector).trigger('set_all', [false]);
		$('.notice_draft .cbx_select_bill [data-bill]').trigger('click');
	});
	$('#btn_select_notice_called').livequery('click', function() {
		$($.bill_selector).trigger('set_all', [false]);
		$('.notice_is_called .cbx_select_bill [data-bill]').trigger('click');
	});
	//未提货报表导出短信群发文本
	$('.btn_export_sms_txt_with_no_delivery').click(function() {
		if ($.bill_selector.selected_ids.length == 0) {
			$.notifyBar({
				html: "请选择要通知的运单!",
				delay: 3000,
				animationSpeed: "normal",
				cls: 'error'
			});
			return false;
		}
		$('#carrying_bill_export_sms_txt_form').remove();
		var export_sms_txt_form = "<form action='/carrying_bills/export_sms_txt.text' method='get' id='carrying_bill_export_sms_txt_form' style='display : none;'></form>";

		$('#table_wrap').before(export_sms_txt_form);
		//附加选中的运单id到form中
		$.each($.bill_selector.selected_ids, function(index, value) {
			var hidden_field = $("<input type='hidden' name='bill_ids[]' value='" + value + "' />");
			$('#carrying_bill_export_sms_txt_form').append(hidden_field);

		});
		$('#carrying_bill_export_sms_txt_form').trigger('submit');
	});

  //提货未提款导出短信群发文件
  $('.btn_export_sms_txt_for_rpt_no_pay').click(function() {
		if ($.bill_selector.selected_ids.length == 0) {
			$.notifyBar({
				html: "请选择运单!",
				delay: 3000,
				animationSpeed: "normal",
				cls: 'error'
			});
			return false;
		}
		$('#carrying_bill_export_sms_txt_form').remove();
		var export_sms_txt_form = "<form action='/carrying_bills/export_sms_txt_for_rpt_no_pay.text' method='post' id='carrying_bill_export_sms_txt_form' style='display : none;'></form>";

		$('#table_wrap').before(export_sms_txt_form);
		//附加选中的运单id到form中
		$.each($.bill_selector.selected_ids, function(index, value) {
			var hidden_field = $("<input type='hidden' name='bill_ids[]' value='" + value + "' />");
			$('#carrying_bill_export_sms_txt_form').append(hidden_field);

		});
		$('#carrying_bill_export_sms_txt_form').trigger('submit');
	});

	//处理运费合计点击切换显示明细
	$('.btn_carrying_fee_total_toogle').livequery('click', function() {
		$('.from_short_carrying_fee,.to_short_carrying_fee').toggle();
	});
	$('.btn_carrying_fee_th_total_toogle').livequery('click', function() {
		$('.carrying_fee_th,.from_short_carrying_fee_th,.to_short_carrying_fee_th,.carrying_fee_1st,.carrying_fee_2st,.manage_fee_th').toggle();
	});
	$('.btn_k_carrying_fee_total_toogle').livequery('click', function() {
		$('.k_carrying_fee,.k_from_short_carrying_fee,.k_to_short_carrying_fee').toggle();
	});

	//运单注销,显示修改备注
	$('.btn_cancel').click(function() {
		var ret = window.prompt("注销后,运单将不能再使用,请录入备注:")
		if (!ret) return false;
		else {
			origin_href = $('.btn_cancel').attr('href');
			$(".btn_cancel").attr('href', origin_href + "?cancel_note=" + ret);
		}
	});

  //运单挂失,显示挂失备注
  $('.btn_bill_report_loss').click(function(){
		var ret = window.prompt("请输入挂失单编号信息:")
		if (!ret) return false;
		else {
			origin_href = $('.btn_bill_report_loss').attr('href');
			$(".btn_bill_report_loss").attr('href', origin_href + "?additional_note=" + ret);
		}
  });
	//滚动信息
	$('#notify-bar marquee').marquee('pointer').mouseover(function() {
		$(this).trigger('stop');
	}).mouseout(function() {
		$(this).trigger('start');
	}).mousemove(function(event) {
		if ($(this).data('drag') == true) {
			this.scrollLeft = $(this).data('scrollX') + ($(this).data('x') - event.clientX);
		}
	}).mousedown(function(event) {
		$(this).data('drag', true).data('x', event.clientX).data('scrollX', this.scrollLeft);
	}).mouseup(function() {
		$(this).data('drag', false);
	});
  //点击gritter 时,关闭该gritter
  $('body').on('click','.gritter-message',function(evt){
		var close_el = $(evt.target).parents('.gritter-item-wrapper').find('.gritter-close');
    close_el.trigger('click');
  });

  //货损理赔/运费调整,处理部门默认选择理赔部
  $('#adjust_fee_info_form .op_org_id option,#goods_exception_form .op_org_id option').each(function(idx){
    var option_text = $(this).text();
    if(option_text.indexOf('理赔') >= 0 )
      $(this).attr('selected',true);
  });
  $('#adjust_goods_fee_info_form .op_org_id option').each(function(idx){
    var option_text = $(this).text();
    if(option_text.indexOf('总公司') >= 0 )
      $(this).attr('selected',true);
  });

  //批量调整货物分类费用信息
  var batch_adjust_goods_cat_config_fee = function(){
    var adjust_rate = parseFloat($('.txt-adjust-rate').val());
    var adjust_price = parseFloat($('.txt-adjust-price').val());
    var adjust_bottom_price = parseFloat($('.txt-adjust-bottom-price').val());
    var copy_from_id = $('#select_other_config').val();
    //判断用户选择
    var which_config = $('input[name=adjust_type]:checked').val();
    if(isNaN(adjust_rate) && isNaN(adjust_price) && isNaN(adjust_bottom_price) && copy_from_id =="") 
      return false;
    //按比例调整单价
    if(which_config == 'by_scale' && !isNaN(adjust_rate)){
      $.each($('.unit-price'),function(idx,el_unit_price){
        var old_price = parseFloat($(el_unit_price).val());
        var new_price = Math.ceil(old_price*(100+adjust_rate)/100);
        $(el_unit_price).val(new_price);
      });
    }
    //按比例调整为空,按金额调整不为空时
    if(which_config == 'by_price' && !isNaN(adjust_price) ){
      $.each($('.unit-price'),function(idx,el_unit_price){
        var old_price = parseFloat($(el_unit_price).val());
        var new_price = Math.ceil(old_price + adjust_price);
        $(el_unit_price).val(new_price);
      });
    }

    //调整底价
    if(which_config == 'by_bottom_price' && !isNaN(adjust_bottom_price)){
      $.each($('.bottom-price'),function(idx,el){
        var old_price = parseFloat($(el).val());
        var new_price = Math.ceil(old_price + adjust_bottom_price);
        $(el).val(new_price);
      });
    }
    //全部调整为默认价
    if(which_config == 'by_default_price'){
      $.each($('.unit-price'),function(idx,el_unit_price){
        var default_price = parseFloat($(el_unit_price).parents('tr').find('.default-price').val());
        $(el_unit_price).val(default_price);
      });
    }

    if(which_config == 'by_other_config' && copy_from_id != ""){
      var copy_price_url = $('#copy_price_path').val() + "?" + "copy_from_id=" + copy_from_id;
      window.location.href = copy_price_url;
    }
    $.fancybox.close();
  };
  $('#btn_batch_adjust').livequery('click',batch_adjust_goods_cat_config_fee);
  //自动弹出msg界面
  $(".unread_msg:first").trigger('click');
});
