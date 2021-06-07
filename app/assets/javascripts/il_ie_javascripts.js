//=require ukey
//ie下重写get_print_object
jQuery(function($) {
	$.extend({
		//导出数据到excel, ie only
		export_excel: function(table_content, func_set_style) {
			try {

				window.clipboardData.setData("Text", table_content);
				ExApp = new ActiveXObject("Excel.Application");
				var ExWBk = ExApp.Workbooks.add();
				var ExWSh = ExWBk.ActiveSheet;
				ExApp.DisplayAlerts = false;
				if (func_set_style) func_set_style(ExWSh);
				ExApp.visible = true;
				ExWSh.Paste();
			}
			catch(e) {
				$.notifyBar({
					html: "导出失败,请确认您已安装excel软件,并调整了IE的安全设置.",
					delay: 3000,
					animationSpeed: "normal",
					cls: 'error'
				});
				return false;
			}
		}
	});
});
