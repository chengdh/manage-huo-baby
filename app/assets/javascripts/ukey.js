//ukey 相关函数的封装
jQuery(function($) {
	$.extend({
		get_ukey_object: function() {
			//先看看是否存在ukey对象
			if ($('#ukeyObject').length == 0) {
				var ukey_object = $('<object classid="clsid:9D6620FE-A05B-4482-B2C7-629DFAE3FB2B" codebase="/assets/ukey.cab#version=1,0,0,1" width="0" height="0" id="ukeyObject"></object>');
				$('body').append(ukey_object);
			}
			return ukeyObject;
		},
		//向ukey写入pin
		ukey_write: function(pin_str) {

			var ukey_object = $.get_ukey_object();
			var message = '';

			var ret = ukey_object.Write(pin_str);
			if (ret == "1001") {
				message = "请重新安装控件！";
				ret_boolean = false;
			} else if (ret == "1002") {
				message = "请检查ukey是否插好!";
				ret_boolean = false;
			} else if (ret == "1003") {
				message = "写入失败！";
				ret_boolean = false;
			} else if (ret == '1000') {
				message = "ukey写入成功!"
				ret_boolean = true;
			}
			$.notifyBar({
				html: message,
				delay: 3000,
				animationSpeed: "normal",
				cls: ret_boolean ? 'success': 'error'
			});
			//alert('write ukey :' + pin_str);
			return ret_boolean;

		},
		//读取ukey pin
		ukey_read: function() {
			var ukey_object = $.get_ukey_object();
			var message = '';
			var ret = "";
			ret = ukey_object.Getstr();
			if (ret == "1001") {
				message = "请重新安装控件！";
				ret_pin = '';
			} else if (ret == "1002") {
				message = "请检查ukey是否插好!";
				ret_pin = '';
			} else if (ret == "1003" || ret == '1004' || ret == '1005' || ret == '1006') {
				message = "没有设置UK码，请初始化ukey!";
				ret_pin = '';
			} else {
				message = "ukey 读取成功!"
				ret_pin = ret;
			}
			//alert('read ukey :' + ret);
			$.notifyBar({
				html: message,
				delay: 3000,
				animationSpeed: "normal",
				cls: ret_pin.length > 0 ? 'success': 'error'
			});
			return ret_pin;
		},

		//删除ukey pin
		ukey_delete: function() {
			var ukey_object = $.get_ukey_object();
			var message = '';

			var ret = ukey_object.Deletestr(pin_str);
			if (ret == "1001") {
				message = "请重新安装控件！";
				ret_boolean = false;
			} else if (ret == "1002") {
				message = "请检查ukey是否插好!";
				ret_boolean = false;
			} else if (ret == "1003") {
				message = "没有设置uk 码！";
				ret_boolean = false;
			} else if (ret == "1004") {
				message = "删除uk码失败v!";
				ret_boolean = false;
			} else if (ret == '1000') {
				message = "ukey删除pin码成功!"
				ret_boolean = true;
			}
			$.notifyBar({
				html: message,
				delay: 3000,
				animationSpeed: "normal",
				cls: ret_boolean ? 'success': 'error'
			});
			return ret_boolean;
		}

	});
	//绑定login_ok按钮
	$('#btn_login_ok').click(function() {
		var login_form = $('#loginform_2');
		var use_usb = $('#use_usb');
		var usb_pin = $('#usb_pin').val();
		//只支持ie
		if (use_usb.val() == 'true' && $.browser.msie) {
			try {
				if ($.ukey_read() == usb_pin) {
					login_form.submit();
				}
				else {
					$.notifyBar({
						html: "UKEY 密码不正确,请确认插入了正确的UKEY!",
						delay: 3000,
						animationSpeed: "normal",
						cls: 'error'
					});

				}
				return false;
			}
			catch(ex) {
				$.notifyBar({
					html: "请先安装ukey驱动!",
					delay: 3000,
					animationSpeed: "normal",
					cls: 'error'
				});

			}
		}
		else login_form.submit();
		return false;
	});
	//保存用户之前,先写入usb key
	$('.new_user,.reset_usb_pin').bind('ajax:before', function() {
		var user_form = $(this);
		var use_usb = $('#user_use_usb');
		var usb_pin = $('#user_usb_pin');
		//只支持ie
		if (use_usb.attr('checked') && $.browser.msie) {
			try {
				if ($.ukey_write(usb_pin.val())) {
					return true;
				}
				else return false;
			}
			catch(ex) {
				$.notifyBar({
					html: "请先安装ukey驱动!",
					delay: 3000,
					animationSpeed: "normal",
					cls: 'error'
				});

			}
		}
		else return true;

	});
});

