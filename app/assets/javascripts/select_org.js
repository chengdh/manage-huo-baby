/*组织机构选择,将select转换为combobox*/
(function($) {
	String.prototype.trim = function() {
		return this.replace(/(^[\s]*)|([\s]*$)/g, "");
	};
	String.prototype.ltrim = function() {
		return this.replace(/(^[\s]*)/g, "");
	};
	String.prototype.rtrim = function() {
		return this.replace(/([\s]*$)/g, "");
	};
	//对jquery selector进行转义
	function escapeExpression(str) {
		return str.replace(/([#;&,\.\+\*\~':"\!\^$\[\]\(\)=>\|"'])/g, "");
	}

	$.fn.select_combobox = function(options) {
		return this.each(function() {
			var select_el = $(this);
			var options = $(this).find('option').clone();
			var input_el = $("<input type='text' class='select_combobox_input' size='20'/>");
			var err_span = $('<span style="color : red;"></span>')
			select_el.hide();
			//插入input_el
			select_el.before(input_el);
			select_el.after(err_span);

			//初次显示时，设置input_el的显示
			var initial_text = options.filter("[value='" + select_el.val() + "']");
			input_el.val(initial_text.text());
			//设置id
			var select_id = select_el.attr("id");
			if (!select_id) select_id = "org_id";
			input_el.attr('id', "select_org_input_" + select_id);
			var func_filter = function(evt) {
				if (evt.keyCode == 13) {
					var keyword = $(this).val().trim();
					var filter_critial = ':contains("' + keyword + '")';
					var ret_options = options.filter(filter_critial).clone();
					select_el.val('');
					err_span.html('');
					//如果没有找到符合条件的数据,则清空文本内容,并设定
					if (ret_options.size() == 0) {
						input_el.val("");
						input_el.focus();
						select_el.val("");
						err_span.html("未找到!")
            $(select_el).trigger('change')
						return false;
					}
					//查询到一个或多各结果
					else {
						input_el.val(ret_options.first().text());
						select_el.val(ret_options.first().val());
            $(select_el).trigger('change')
					}
				}

			};
			input_el.bind('keydown', func_filter);

		});
	};

	// Overwrite this method to provide options on a per-element basis.
	// For example, you could store the gravity in a 'tipsy-gravity' attribute:
	// return $.extend({}, options, {gravity: $(ele).attr('tipsy-gravity') || 'n' });
	// (remember - do not modify 'options' in place!)
	$.fn.select_combobox.elementOptions = function(ele, options) {
		return $.metadata ? $.extend({},
		options, $(ele).metadata()) : options;
	};

})(jQuery);
