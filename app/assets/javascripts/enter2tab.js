jQuery(function($) {
	var enter2tab = function(e) {
		if (e.keyCode == 13) {
			var target_el = e.target;
			/* FOCUS ELEMENT */
			var inputs = $(this).find('input:visible,select:visible,textarea:visible');
			var idx = inputs.index(target_el);

			if (idx == inputs.length - 1) {
				//自动跳到保存按钮上
				//$(inputs[idx]).change();
				$('.btn_save:first').focus();
			} else {
				//$(inputs[idx]).change(); //  handles submit buttons
				inputs[idx + 1].focus(); //  handles submit buttons
				var tag_name = $(inputs[idx + 1])[0].tagName.toLowerCase();
				if (tag_name == 'input' || tag_name == 'textarea') inputs[idx + 1].select();
			}
			return false;
		}

	};
	var on_focus = function(evt) {
		var target_el = evt.target;
		var tag_name = $(target_el)[0].tagName.toLowerCase();
		if ((tag_name == 'input' && $(target_el).attr('type').toLowerCase() == 'text') || tag_name == 'textarea' || tag_name == 'select') {
			$(target_el).css({
				backgroundColor: '#68B4EF'
			});

		}
	};
	var on_blur = function(evt) {
		var target_el = evt.target;

		var tag_name = $(target_el)[0].tagName.toLowerCase();
		if ((tag_name == 'input' && $(target_el).attr('type').toLowerCase() == 'text') || tag_name == 'textarea' || tag_name == 'select') {
			$(target_el).css({
				backgroundColor: '#FFF'
			});
			if ($(target_el).attr('readonly')) $(target_el).css({
				backgroundColor: '#EDEDED'
			});
		}

	};
	$('form[id!="home-search-form"],.enter2tab').live('keydown', enter2tab).live("blur", on_blur).live("focus", on_focus);
});
