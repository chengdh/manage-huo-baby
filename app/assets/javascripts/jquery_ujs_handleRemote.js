//修改handleRemote函数,使form对象可以附加data-params
(function($, undefined) {
	var rails;
	rails = $.rails;
	$.rails.handleRemote = function(element) {
		var method, url, data,formData,crossDomain, dataType, options;

		if (rails.fire(element, 'ajax:before')) {
			crossDomain = element.data('cross-domain') || null;
			dataType = element.data('type') || ($.ajaxSettings && $.ajaxSettings.dataType);

			if (element.is('form')) {
				method = element.attr('method');
				url = element.attr('action');
				data = element.serializeArray();

        //判断有无multipart属性
        var attr = $(element).attr('enctype');
        // For some browsers, `attr` is undefined; for others, `attr` is false. Check for both.
        if (typeof attr !== typeof undefined && attr !== false && attr == 'multipart/form-data') {
          formData = new FormData($(element)[0]);

          var dataParams = element.data('params');
          if (typeof dataParams !== typeof undefined && attr !== false) {
            for (var k in dataParams){
              var vObj = dataParams[k];
              if($.isPlainObject(vObj)){
                formData.append(k,vObj);
              }

              if($.isArray(vObj)){
                $.each(vObj,function(i,val){
                  formData.append(k,val);
                });
              }
            }
          }
        }

				// memoized value from clicked submit button
				var button = element.data('ujs:submit-button');
				if (button) {
					data.push(button);
					element.data('ujs:submit-button', null);
				}
        if (element.data('params')){
          data = ($.isPlainObject(element.data('params')) ? $.param(element.data('params')) : element.data('params')) + '&' + $.param(element.serializeArray());
        }

			} else if (element.is(rails.inputChangeSelector)) {
				method = element.data('method');
				url = element.data('url');
				data = element.serialize();
				if (element.data('params')) data = data + "&" + element.data('params');
			} else {
				method = element.data('method');
				url = rails.href(element);
				data = element.data('params') || null;
			}
      
			options = {
				type: method || 'GET',
				data: data,
				dataType: dataType,
				crossDomain: crossDomain,
				// stopping the "ajax:beforeSend" event will cancel the ajax request
				beforeSend: function(xhr, settings) {
					if (settings.dataType === undefined) {
						xhr.setRequestHeader('accept', '*/*;q=0.5, ' + settings.accepts.script);
					}
					return rails.fire(element, 'ajax:beforeSend', [xhr, settings]);
				},
				success: function(data, status, xhr) {
					element.trigger('ajax:success', [data, status, xhr]);
				},
				complete: function(xhr, status) {
					element.trigger('ajax:complete', [xhr, status]);
				},
				error: function(xhr, status, error) {
					element.trigger('ajax:error', [xhr, status, error]);
				}
			};

      //判断是否form
      if(element.is('form')){
        var attr = $(element).attr('enctype');
        // For some browsers, `attr` is undefined; for others, `attr` is false. Check for both.
        if (typeof attr !== typeof undefined && attr !== false && attr == 'multipart/form-data') {
          options.data = formData;
          options.type = 'POST';
          options.enctype = 'multipart/form-data';
          options.processData =  false;
          options.contentType = false;
          options.cache = false;
          options.timeout = 600000;
        }
      }

			// Only pass url to `ajax` options if not blank
			if (url) {
				options.url = url;
			}

			return rails.ajax(options);
		} else {
			return false;
		}
	};
})(jQuery);

