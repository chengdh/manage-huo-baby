// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//bill_selector
jQuery(function($) {
	$.bill_selector = function() {};
	$.extend($.bill_selector, {
		//初始化函数
		//el 初始化的table_el
		//option 初始化的一些选项
		initialize: function(el, options) {

			if (!!$.bill_selector.initialized);
			else {
				$.bill_selector.reset();
				$.bill_selector.el = el;
				$.bill_selector.ids = []; //$.bill_selector.el.data('ids');
				$.bill_selector.sum_info = {};
				$.bill_selector.selected_ids = $.bill_selector.el.data('ids').slice();

				//http://stackoverflow.com/questions/7668826/jquery-triggerclick-not-firing-click-event-on-checkbox
				//jquery中checkbox click事件的问题
				$('.cbx_select_bill [data-bill]').live('change', $.bill_selector.bill_click);
				$($.bill_selector).bind('set_all', $.bill_selector.set_all);
				//绑定全选和不选按钮
				$('#btn_select_all').live("click", function() {
					$($.bill_selector).trigger('set_all', [true]);
				});
				$('#btn_unselect_all').live("click", function() {
					$($.bill_selector).trigger('set_all', [false]);
				});

				$($.bill_selector).trigger('set_all', [true]);
				$.bill_selector.initialized = true;
			}
			//显示票据选择控件
			$('.select_bill_bar,.cbx_select_bill').livequery(function() {
				$(this).show();
			});
			//给显示票据详细信息的链接添加fancybox属性
			$('.show_link').addClass('fancybox');
      /*
			$('.show_link').each(function() {
				var href = $(this).attr('href');
				$(this).attr('href', href + '.js');
			});
            */
			$.bill_selector.set_checkbox();
			$.bill_selector.update_html();

		},
		//重置对象,重新初始化
		reset: function() {
			$.bill_selector.initialized = false;
			$('[data-bill]').die('click');
			$($.bill_selector).unbind('set_all');
			//绑定全选和不选按钮
			if (typeof($.bill_selector.options) != 'undefined') {
				$('#btn_select_all').die('click');
				$('#btn_unselect_all').die('click');
			}

		},
		//合计的对象的键值对象
    //该键值和data-bill属性对象的attr相对应,比如sum_carrying_fee => bill.carrying_fee
		sum_info_key_array: [
      "sum_count", "sum_carrying_fee", "sum_carrying_fee_total", 
      "sum_carrying_fee_th", "sum_k_carrying_fee", "sum_carrying_fee_th_total", 
      "sum_k_carrying_fee_total", "sum_k_hand_fee", "sum_act_pay_fee", 
      "sum_goods_fee", "sum_transit_carrying_fee", "sum_transit_hand_fee", 
      "sum_agent_carrying_fee", "sum_th_amount",
      "sum_insured_fee", "sum_insured_fee_th", "sum_k_insured_fee",
      "sum_manage_fee","sum_manage_fee_th","sum_k_manage_fee", 
      "sum_from_short_carrying_fee", "sum_from_short_carrying_fee_th", "sum_k_from_short_carrying_fee", 
      "sum_to_short_carrying_fee", "sum_to_short_carrying_fee_th", "sum_k_to_short_carrying_fee",
      "sum_carrying_fee_1st","sum_carrying_fee_2st","sum_adjust_carrying_fee_plus","sum_adjust_carrying_fee_minus",
      "sum_goods_weight","sum_goods_volume"],
		//选中或不选中全部
		set_all: function(event, is_select) {
			$.bill_selector.selected_ids = is_select ? $.bill_selector.el.data('ids').slice() : [];
			if (is_select) {
				var sum_info = $.bill_selector.el.data('sum');
				$.each($.bill_selector.sum_info_key_array, function(unused, key) {
					$.bill_selector.sum_info[key] = parseFloat(sum_info[key]);
				});
			}
			else {
				$.each($.bill_selector.sum_info_key_array, function(unused, key) {
					$.bill_selector.sum_info[key] = 0;
				});
			}
			$.bill_selector.set_checkbox();
			$.bill_selector.update_html();

		},
		//根据选择情况,设置checkbox的选中情况
		set_checkbox: function() {
			$('input[type|="checkbox"][data-bill]').attr('checked', false);
			jQuery.each($.bill_selector.selected_ids, function(index, value) {
				$('input[type|="checkbox"][value|="' + value + '"]').attr('checked', true);
			});

		},

		//选中或不选中某张票据
		bill_click: function(event) {
			var cur_el = $(event.currentTarget);
			var the_bill = cur_el.data('bill');
			if (cur_el.attr('checked')) {
				//向selected_ids中添加选中票据的id
				if ($.inArray(the_bill.id, $.bill_selector.selected_ids) == - 1) $.bill_selector.selected_ids.push(the_bill.id);
				$.each($.bill_selector.sum_info_key_array, function(unused, key) {
					if (key == 'sum_count') $.bill_selector.sum_info[key] += 1;
					else $.bill_selector.sum_info[key] += parseFloat(the_bill[key.slice(4)]);
				});
			}
			else {
				var index = $.inArray(the_bill.id, $.bill_selector.selected_ids)
				if (index > - 1) $.bill_selector.selected_ids.splice(index, 1);

				$.each($.bill_selector.sum_info_key_array, function(unused, key) {
					if (key == 'sum_count') $.bill_selector.sum_info[key] -= 1;
					else $.bill_selector.sum_info[key] -= parseFloat(the_bill[key.slice(4)])
				});
			}
			$.bill_selector.update_html();
		},
		//更新界面显示
		update_html: function() {
			$.each($.bill_selector.sum_info_key_array, function(unused, key) {
				$('#' + key).html($.bill_selector.sum_info[key])
			});
			//触发选择改变事件
			$($.bill_selector).trigger('select:change');

		}

	});
	$.fn.bill_selector = function(options) {
		$.bill_selector.initialize(this, options);
	};

	//扩展form,使其可以选择运单,大车装车单,分货单,提货单,返款清单都属于此类
	$.fn.form_with_select_bills = function(setting) {
		var options = $.extend({},
		$.fn.form_with_select_bills.defaults, setting);
		$(options.bills_table).livequery(function() {
			$(this).bill_selector();
		});

		//绑定ajax:before事件
		var ajax_before = function() {
			if (typeof($.bill_selector.selected_ids) == 'undefined' || $.bill_selector.selected_ids.length == 0) {
				$.notifyBar({
					html: "当前未选择任何要处理的运单,请先选择要处理的运单",
					delay: 3000,
					animationSpeed: "normal",
					cls: 'error'
				});

				return false;
			}
			else {
				//将选择的运单ids附加到form上
				var attach_params = {
					"bill_ids[]": $.bill_selector.selected_ids
				};
				$(this).data('params', attach_params);
			}
			return true;

		};
		$(this).bind("ajax:before", ajax_before);
		//查询运单函数
		var search_bills = function() {
			$.get('/carrying_bills', options["search_bill_params"](), function() {
				$.bill_selector.reset();
			},
			'script');
		};
		//自动将默认参数传递给search_form
		var set_search_form = function() {
			var default_values = options["search_bill_params"]();
			//判断是否传递了发货地与到货地
			if (default_values["from_org_id_eq"] != "") {
				$('#search_from_org_id_eq').val(default_values["from_org_id_eq"]).trigger('change');
				$('#search_from_org_id_eq').attr('disabled', true);
				jQuery.extend(default_values, {
					"search[from_org_id_eq]": default_values["from_org_id_eq"]
				});
			}
			if (default_values["to_org_id_eq"] != "") {
				$('#search_to_org_id_or_transit_org_id_eq').val(default_values["to_org_id_eq"]).trigger('change');
				$('#search_to_org_id_or_transit_org_id_eq').attr('disabled', true);
				jQuery.extend(default_values, {
					"search[to_org_id_or_transit_org_id_eq]": default_values["to_org_id_eq"]
				});
			}
			if (default_values["to_org_id_or_transit_org_id_eq"] != "") {
				$('#search_to_org_id_or_transit_org_id_eq').val(default_values["to_org_id_or_transit_org_id_eq"]).trigger('change');
				$('#search_to_org_id_or_transit_org_id_eq').attr('disabled', true);
				jQuery.extend(default_values, {
					"search[to_org_id_or_transit_org_id_eq]": default_values["to_org_id_or_transit_org_id_eq"]
				});
			}

			if (default_values["search[state_eq]"] != "") {
				$('#search_state_eq').val(default_values["search[state_eq]"]).trigger('change');
				$('#search_state_eq').attr('disabled', true);
				jQuery.extend(default_values, {
					"search[state_eq]": default_values["search[state_eq]"]
				});
			}
			if (default_values["search[state_in]"] != "") {
				$('#search_state_eq').val("").trigger('change');
				$('#search_state_eq').attr('disabled', true);
			}

			//传递了要查询的单据状态
			$('#search_bill_form').data('params', default_values)
		};
		$('#search_bill_form').livequery(function() {
			set_search_form();
		});
		return this;
	};
	//默认设置
	$.fn.form_with_select_bills.defaults = {
		//运单列表table
		bills_table: '#bills_table',
		//是否与search_bill_form关联
		with_search_bill_form: true,
		//form提交时附加到form上的已选择的运单数组
		search_bill_params: function() {
			var ret = {
				"from_org_id_eq": ($('#from_org_id').length == 0) ? "": $('#from_org_id').val(),
				"to_org_id_eq": ($('#to_org_id').length == 0) ? "": $('#to_org_id').val(),
				"to_org_id_or_transit_org_id_eq": ($('#to_org_id_or_transit_org_id').length == 0) ? "": $('#to_org_id_or_transit_org_id').val(),
				"transit_org_id_eq": ($('#transit_org_id').length == 0) ? "": $('#transit_org_id').val(),
				"search[bill_date_eq]": ($('#bill_date_eq').length == 0) ? "": $('#bill_date_eq').val(),
				"search[type_in][]": ($('#type_in').length == 0) ? ['ComputerBill', 'HandBill', 'ReturnBill', 'TransitBill', 'HandTransitBill', 'AutoCalculateComputerBill'] : $('#type_in').data('type') //要查询的运单类型
			}
      if($('#state_eq').length > 0){
        ret["search[state_eq]"] = $('#state_eq').val();
      }

      if($('#state_in').length > 0){
        ret["search[state_in][]"] = $('#state_in').data('states');
      }
      return ret;
		}
	}
});

