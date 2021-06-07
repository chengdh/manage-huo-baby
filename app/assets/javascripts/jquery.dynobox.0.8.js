/*
	Copyright (c) 2009 Oscar Godson

	Permission is hereby granted, free of charge, to any person
	obtaining a copy of this software and associated documentation
	files (the "Software"), to deal in the Software without
	restriction, including without limitation the rights to use,
	copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the
	Software is furnished to do so, subject to the following
	conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
	OTHER DEALINGS IN THE SOFTWARE.
	
	Version 0.8
	TODO:
	Test in ALL the following IE7+, FF3+, Safari 3.2+, Chrome when it hits version 1.0
	Add option: add Class to show states :default or :usertext
	Add option: specify class names for default and user text
	fix: select bug. If you focus, blur, focus, that last focus will not work with select()?
	
	Example default useage;
	$('input[type=text]').dynoBox();
	
	Example to add text inside the input from a label:
	$('input[type=text]').dynoBox({addFromLabel:'#header label'});
	
*/
(function($) {
	$.fn.extend({
		dynoBox: function(options) {
			var defaults = {
				value:'Search', //The default value to be placed inside
				defaultTextFocus:'auto', //Default action when default text is in place and the input is focused (auto = erase)
				defaultTextBlur:'auto', //Default action when the default text is in place and the input is blurred (auto = revert)
				userTextFocus:'auto', //Default action when the user text is in place and the input is focused (auto = nothing)
				userTextBlur:'auto', //Default action when the user text is in place and the input is blurred (auto = nothing)
				resetOnLoad:true, //Do you want the text inside of the input box to be replaced when the user refreshes or goes back?
				addFromLabel:'', //This will override the "value" option. Target the label with a selector
				hideLabel:true, //This will only fire IF there is an addFromLabel set. Do you want the label to be hidden?
				addClasses:true, //NOT YET IN USE
				defaultTextClass:'dynoBoxDefault', //NOT YET IN USE
				userTextClass:'dynoBoxUser' //NOT YET IN USE
			};
			
			var options = $.extend(defaults, options);
			var default_value;

			return this.each(function() {
				var obj = $(this);
				
				if(options.addFromLabel.length>0){
					the_label = $(options.addFromLabel);
					default_value = $(the_label).text();
					if(options.hideLabel){$(the_label).css({display:'none'});}
				}
				else{
					default_value = options.value;
				}
				
				if(options.resetOnLoad){
					$(obj).attr('value',default_value)
				}
				
				function alertVal(){
					alert($(obj).val());
				}
				function eraseVal(){
					$(obj).attr('value','');
				}
				function revertVal(){
					$(obj).attr('value',default_value);
				}
				$(obj).focus(function(){
					if($(obj).attr('value') == default_value){
						switch(options.defaultTextFocus){
							case 'erase':
								eraseVal();
								break;
							case 'select':
								$(obj).select();
								break;
							case 'nothing':
								break;
							case 'debug':
								alertVal();
								break;
							default:
								eraseVal();
								break;
						}
					}
					else{
						switch(options.userTextFocus){
							case 'erase':
								eraseVal();
								break;
							case 'select':
								$(obj).select();
								break;
							case 'debug':
								alertVal();
								break;
						}
					}
				}).blur(function(){
					if($(obj).attr('value') == '' || $(obj).attr('value') == ' '){
						switch(options.defaultTextBlur){
							case 'revert':
								revertVal();
								break;
							case 'nothing':
								break;
							case 'debug':
								alertVal();
								break;
							default:
								revertVal();
								break;
						}
					}
					else{
						switch(options.userTextBlur){
							case 'revert':
								revertVal();
								break;
							case 'debug':
								alertVal();
								break;
						}
					}
				});
			});
		}
	});
})(jQuery);