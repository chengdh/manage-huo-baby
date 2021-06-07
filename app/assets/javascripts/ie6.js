/*IE6下的特定处理*/
jQuery(function($) {
	$('.table tbody').hover(function() {
		$(this).css({
			cursor: 'pointer'
		});
	});

	/*使jquery notify bar 固定显示在顶部*/
	$('.jquery-notify-bar').livequery(function() {
		$(this).addClass('fixed-top');
	});
});

