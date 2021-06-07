/*
	ufd 0.6 : Unobtrusive Fast-filter Drop-down jQuery plugin.

	Authors:
		thetoolman@gmail.com
		Kadalashvili.Vladimir@gmail.com

	Version:  0.6

	Website: http://code.google.com/p/ufd/
 */

(function($) {

var widgetName = "ui.ufd";

$.widget(widgetName, {

	// options: provided by framework
	// element: provided by framework

	_init: function() { //1.7 init
		// in 1.8 this method is  "default functionality" which we dont have; here for 1.7 support
		if(!this.created) this._create();
	},

	_create: function() { //1.8 init
		if(this.created) return;
		this.created = true;

		if (this.element[0].tagName.toLowerCase() != "select") {
			this.destroy();
			return false;
		}

		// this._timingMeasure(true, "init");

		this.options = $.extend(true, {}, this.options); //deep copy: http://dev.jqueryui.com/ticket/4366

		this.visibleCount = 0;
		this.selectbox = this.element;
		this.logNode = $(this.options.logSelector);
		this.overflowCSS = this.options.allowLR ? "overflow" : "overflowY";
		var selectName = this.selectbox.attr("name");
		var prefixName = this.options.prefix + selectName;
		var inputName = this.options.submitFreeText ? selectName : prefixName;
		var inputId = ""; // none unless master select has one

		var sbId = this.selectbox.attr("id");

		if(sbId) {
			inputId = this.options.prefix + sbId ;
			this.labels = $("label[for='" + sbId + "']").attr("for", inputId);
		}

		if(this.options.submitFreeText) this.selectbox.attr("name", prefixName);
		if(this.options.calculateZIndex) this.options.zIndexPopup = this._calculateZIndex();

		var css = this.options.css;
		this.css = this.options.css;
		if(this.options.useUiCss) $.extend(this.css, this.options.uiCss);
		if(!css.skin) css.skin = this.options.skin; // use option skin if not specified in CSS

		this.wrapper = $([
			'<span class="', css.wrapper, ' ', css.hidden, ' ', css.skin, '">',
				'<input type="text" id="',inputId,'" class="', css.input, '" name="', inputName, '"/>',
				'<button type="button" tabindex="-1" class="', css.button, '"><div class="', css.buttonIcon, '"/></button>',
			//   <select .../> goes here
			'</span>'
		].join(''));
		this.dropdown = $([
			'<div class="', css.skin, '">',
				'<div class="', css.listWrapper, ' ', css.hidden, '">',
					'<div class="', css.listScroll, '">',
					//  <ul/> goes here
					'</div>',
				'</div>',
			'</div>'
		].join(''));

		this.selectbox.after(this.wrapper);
		this.getDropdownContainer().append(this.dropdown);

		this.input = this.wrapper.find("input");
		this.button = this.wrapper.find("button");
		this.listWrapper = this.dropdown.children(":first").css("z-index", this.options.zIndexPopup);
		this.listScroll = this.listWrapper.children(":first");

		if($.fn.bgiframe) this.listWrapper.bgiframe(); //ie6 !

		// check browser supports min-width, revert to fixed if no support - Looking at you, iE6...
		if(!this.options.listWidthFixed){
			this.listWrapper.css({"width": 50, "min-width": 100});
			this.options.listWidthFixed = (this.listWrapper.width() < 100);
			this.listWrapper.css({"width": null, "min-width": null});
		}

		this._populateFromMaster();
		this._initEvents();

		// this._timingMeasure(false, "init");
	},


	_initEvents: function() { //initialize all event listeners
		var self = this;
		var keyCodes = $.ui.keyCode;
		var key, isKeyDown, isKeyPress,isKeyUp;
		var css = this.options.css;

		// this.log("initEvents");

		this.input.bind("keydown keypress keyup", function(event) {
			// Key handling is tricky; here is great key guide: http://unixpapa.com/js/key.html
			isKeyDown = (event.type == "keydown");
			isKeyPress = (event.type == "keypress");
			isKeyUp = (event.type == "keyup");
			key = null;

			if (undefined === event.which) {
				key = event.keyCode;
			} else if (!isKeyPress && event.which != 0) {
				key = event.keyCode;
			} else {
				return; //special key
			}

			switch (key) { //stop default behivour for these events
				case keyCodes.HOME:
				case keyCodes.END:
					if(self.options.homeEndForCursor) return; //no action except default
				case keyCodes.DOWN:
				case keyCodes.PAGE_DOWN:
				case keyCodes.UP:
				case keyCodes.PAGE_UP:
				case keyCodes.ENTER:
					//self.stopEvent(event);
				default:
			}

			// only process: keyups excluding tab/return; and only tab/return keydown
			// Only some browsers fire keyUp on tab in, ignore if it happens
			if(!isKeyUp == ((key != keyCodes.TAB) && (key != keyCodes.ENTER)) ) return;

			// self.log("Key: " + key + " event: " + event.type);

			self.lastKey = key;

			switch (key) {
			case keyCodes.SHIFT:
			case keyCodes.CONTROL:
				//don't refilter
				break;

			case keyCodes.DOWN:
				self.selectNext(false);
				break;
			case keyCodes.PAGE_DOWN:
				self.selectNext(true);
				break;
			case keyCodes.END:
				self.selectLast();
				break;

			case keyCodes.UP:
				self.selectPrev(false);
				break;
			case keyCodes.PAGE_UP:
				self.selectPrev(true);
				break;
			case keyCodes.HOME:
				self.selectFirst();
				break;

			case keyCodes.ENTER:
				self.hideList();
				self.tryToSetMaster();
				self.inputFocus();
				break;
			case keyCodes.TAB: //tabout only
				self.realLooseFocusEvent();
				break;
			case keyCodes.ESCAPE:
				self.hideList();
				self.revertSelected();
				break;

			default:
				self.showList();
				self.filter(false, true); //do delay, as more keypresses may cancel
				break;
			}
		});

		this.input.bind("click", function(e) {
			if(self.isDisabled){
				self.stopEvent(e);
				return;
			}
			// self.log("input click: " + e.target);
			if (!self.listVisible()) {
				self.filter(true); //show all
				self.inputFocus();
				self.showList();
			}
		});
		this.input.bind("focus", function(e) {
			if(self.isDisabled){
				self.stopEvent(e);
				return;
			}
			// self.log("input focus");
			if(!self.internalFocus){
				self.realFocusEvent();
			}
		});

		this.button.bind("mouseover", function(e) { self.button.addClass(css.buttonHover); });
		this.button.bind("mouseout",  function(e) { self.button.removeClass(css.buttonHover); });
		this.button.bind("mousedown", function(e) { self.button.addClass(css.buttonMouseDown); });
		this.button.bind("mouseup",   function(e) { self.button.removeClass(css.buttonMouseDown); });
		this.button.bind("click", function(e) {
			if(self.isDisabled){
				self.stopEvent(e);
				return;
			}
			// self.log("button click: " + e.target);
			if (self.listVisible()) {
				self.hideList();
				self.inputFocus();

			} else {
				self.filter(true); //show all
				self.inputFocus();
				self.showList();
			}
		});

		/*
		 * Swallow mouse scroll to prevent body scroll
		 * thanks http://www.switchonthecode.com/tutorials/javascript-tutorial-the-scroll-wheel
		*/
		this.listScroll.bind("DOMMouseScroll mousewheel", function(e) {
			self.stopEvent(e);
			e = e ? e : window.event;
			var normal = e.detail ? e.detail * -1 : e.wheelDelta / 40;

			var curST = self.listScroll.scrollTop();
			var newScroll = curST + ((normal > 0) ? -1 * self.itemHeight : 1 * self.itemHeight);
			self.listScroll.scrollTop(newScroll);
		});

		this.listScroll.bind("mouseover mouseout click", function(e) {
			if ( "LI" == e.target.nodeName.toUpperCase() ) {
				if(self.setActiveTimeout) { //cancel pending selectLI -> active
					clearTimeout(self.setActiveTimeout);
					self.setActiveTimeout == null;
				}
				if ("mouseout" == e.type) {
					$(e.target).removeClass(css.liActive);
					self.setActiveTimeout = setTimeout(function() {
						$(self.selectedLi).addClass(css.liActive);
					}, self.options.delayYield);

				} else if ("mouseover" == e.type) {
					if (self.selectedLi != e.target) {
						$(self.selectedLi).removeClass(css.liActive);
					}
					$(e.target).addClass(css.liActive);

				} else { //click
					self.stopEvent(e); //prevent bubbling to document onclick binding etc
					var value = $.trim($(e.target).text());
					self.input.val(value);
					self.setActive(e.target);
					if(self.tryToSetMaster() ) {
						self.hideList();
						self.filter(true); //show all
					}
					self.inputFocus();
				}
			}

			return true;
		});

		this.selectbox.bind("change." + widgetName, function(e) {
			if(self.isUpdatingMaster){
				// self.log("master changed but we did the update");
				self.isUpdatingMaster = false;
				return true;
			}
			// self.log("master changed; reverting");
			self.revertSelected();
		});

		// click anywhere else; keep reference for selective unbind
		this._myDocClickHandler = function(e) {
			if ((self.button.get(0) == e.target) || (self.input.get(0) == e.target)) return;
			// self.log("unfocus document click : " + e.target);
			if (self.internalFocus) self.realLooseFocusEvent();
		};
		$(document).bind("click." + widgetName, this._myDocClickHandler);

		// polling for disabled, dimensioned
		if(this.options.polling) {
			var self = this; // shadow self var - less lookup chain == faster
			this._myPollId = setInterval(function() {
				// fast as possible
				if(!self.dimensioned) self.setDimensions();
				if(self.selectbox[0].disabled != self.isDisabled) {
					(self.selectbox[0].disabled) ? self.disable() : self.enable();
				}

			}, self.options.polling);
		}

	},

	// pseudo events

	realFocusEvent: function() {
		// this.log("real input focus");
		this.internalFocus = true;
		this._triggerEventOnMaster("focus");
		this.wrapper.addClass(this.options.css.skin + "-" + this.options.css.inputFocus); // for ie6 support
		this.input.addClass(this.options.css.inputFocus);
		this.button.addClass(this.options.css.inputFocus);
		this.filter(true); //show all
		this.inputFocus();
		this.showList();
	},

	realLooseFocusEvent: function() {
		// this.log("real loose focus (blur)");
		this.internalFocus = false;
		this.hideList();
		this.wrapper.removeClass(this.options.css.skin + "-" + this.options.css.inputFocus);
		this.input.removeClass(this.options.css.inputFocus);
		this.button.removeClass(this.options.css.inputFocus);
		this.tryToSetMaster();
		this._triggerEventOnMaster("blur");
	},

	_triggerEventOnMaster: function(eventName) {
		if( document.createEvent ) { // good browsers
			var evObj = document.createEvent('HTMLEvents');
			evObj.initEvent( eventName, true, true );
			this.selectbox.get(0).dispatchEvent(evObj);

		} else if( document.createEventObject ) { // iE
			this.selectbox.get(0).fireEvent("on" + eventName);
		}

	},

	// methods

	inputFocus: function() {
		// this.log("inputFocus: restore input component focus");
		this.input.focus();

		if (this.getCurrentTextValue().length) {
			this.selectAll();
		}
	},

	inputBlur: function() {
		// this.log("inputBlur: loose input component focus");
		this.input.blur();
	},

	showList: function() {
		// this.log("showlist");
		if(this.listVisible()) return;
		this.listWrapper.removeClass(this.css.hidden);
		this.setListDisplay();
	},

	hideList: function() {
		// this.log("hide list");
		if(!this.listVisible()) return;
		this.listWrapper.addClass(this.css.hidden);
		this.listItems.removeClass(this.css.hidden);
	},

	/*
	 * adds / removes items to / from the dropdown list depending on combo's current value
	 *
	 * if doDelay, will delay execution to allow re-entry to cancel.
	 */
	filter: function(showAll, doDelay) {
		// this.log("filter: " );
		var self = this;

		//cancel any pending
		if(this.updateOnTimeout) clearTimeout(this.updateOnTimeout);
		if(this.filterOnTimeout) clearTimeout(this.filterOnTimeout);
		this.updateOnTimeout = null;
		this.filterOnTimeout = null;

		var searchText = self.getCurrentTextValue();

		var search = function() {
			// self.log("filter search");
			// this._timingMeasure(true, "filter search");
			var mm = self.trie.find(searchText); // search!
			self.trie.matches = mm.matches;
			self.trie.misses = mm.misses;
			// this._timingMeasure(false, "filter search");

			//yield then screen update
			self.updateOnTimeout = setTimeout(function(){screenUpdate();}, self.options.delayYield);

		};

		var screenUpdate = function() {
			// self.log("screen update");

			// this._timingMeasure(true, "screenUpdate");
			var active = self.getActive(); //get item before class-overwrite

			if (self.options.addEmphasis) {
				self.emphasis(self.trie.matches, true, searchText);
			}

			self.visibleCount = self.overwriteClass(self.trie.matches, "" );
			if(showAll || !self.trie.matches.length) {
				self.visibleCount += self.overwriteClass(self.trie.misses, "" );
				if (self.options.addEmphasis) {
					self.emphasis(self.trie.misses, false, searchText);
				}
			} else {
				self.overwriteClass(self.trie.misses, self.css.hidden);
			}
			var oldActiveHidden =  active.hasClass(self.css.hidden) ;

			// need to set overwritten active class
			if(!oldActiveHidden && active.length && self.trie.matches.length){
				self.setActive(active.get(0));

			} else {
				var firstmatch = self.listItems.filter(":visible:first");
				self.setActive(firstmatch.get(0));

			}
			// this._timingMeasure(false, "screenUpdate");


			self.setListDisplay();
		};

		if(doDelay) {
			//setup new delay
			this.filterOnTimeout = setTimeout( function(){ search(); }, this.options.delayFilter );
		} else {
			search();
		}
	},

	/*
	 * replace chars with entity encoding
	 */
	_encodeDom: $('<div/>'),
	_encodeString: function(toEnc) {
		return $.trim(this._encodeDom.text(toEnc).html());
	},

	emphasis: function(array, isAddEmphasis, searchText ) {

		var tritem, index, indexB, li, text, stPattern, escapedST;
		var searchTextLength = searchText.length || 0;
		var options = this.selectbox.get(0).options;
		index = array.length;

		isAddEmphasis = (isAddEmphasis && searchTextLength > 0); // don't add emphasis to 0-length

		if(isAddEmphasis) {
			// html encode search string to match innerHTML then escape regexp chars; thanks http://xkr.us/js/regexregex
			escapedST = this._encodeString(searchText).replace(/([\\\^\$*+[\]?{}.=!:(|)])/g,"\\$1");
			stPattern = new RegExp("(" + escapedST + ")", "gi"); // $1
			this.hasEmphasis = true;
		}
		// this.log("add emphasis? " + isAddEmphasis);
		// this._timingMeasure(true, "em");
		while(index--) {
			tritem = array[index];
			indexB = tritem.length;
			while(indexB--) { // duplicate match array
				li = tritem[indexB];
				text = $.trim(options[li.getAttribute("name")].innerHTML);
				li.innerHTML = isAddEmphasis ? text.replace(stPattern, "<em>$1</em>") : text;
			}
		}
		// this._timingMeasure(false, "em");
	},

	/*
	_timingMeasure_agnostic : function(label, isStart) {
		if(isStart) {
			this._tm[label] = new Date().getTime();
		} else {
			var start = this._tm[label];
			var dur = (new Date().getTime()) - start;
			alert(label + ": millis - " + dur);
		}
	},
	_tm : {},
	*/
	_timingMeasure_firebug : function(isStart, label) {
		if(isStart) {
			console.time(label);
		} else {
			console.timeEnd(label);
		}
	},
	_timingMeasure : function(isStart, label) {
		this._timingMeasure_firebug(isStart, label);
	},
	removeEmphasis : function() {
		// this.log("remove emphasis");
		if(!this.hasEmphasis){
			// this.log("no emphasis to remove");
			return;
		}
		// this._timingMeasure(true, "rem");
		this.hasEmphasis = false;
		var options = this.selectbox.get(0).options;
		var theLiSet = this.list.get(0).getElementsByTagName('LI'); // much faster array then .childElements !
		var liCount = theLiSet.length;
		var li;
		while(liCount--){
			var li = theLiSet[liCount];
			li.innerHTML = $.trim(options[li.getAttribute("name")].innerHTML);
		}


		// this._timingMeasure(false, "rem");

	},

	// attempt update of master - returns true if update good or already set correct.
	tryToSetMaster: function() {
		// this.log("t.s.m");

		var optionIndex = null;
		var active = this.getActive();
		if (active.length) {
			optionIndex = active.attr("name"); //sBox pointer index
		}
		if (optionIndex == null || optionIndex == "" || optionIndex < 0) {
			// this.log("no active, master not set.");
			if (this.options.submitFreeText) {
				return false;

			} else {
				// this.log("Not freetext and no active set; revert.");
				this.revertSelected();
				return false;
			}
		} // else optionIndex is set to activeIndex

		var sBox = this.selectbox.get(0);
		var curIndex = sBox.selectedIndex;
		var option = sBox.options[optionIndex];

		if(!this.options.submitFreeText || this.input.val() == option.text){ //freetext only if exact match
			this.input.val(option.text); // input may be only partially set

			if(optionIndex != curIndex){
				this.isUpdatingMaster = true;
				sBox.selectedIndex = optionIndex;
				// this.log("master selectbox set to: " + option.text);
				this._triggerEventOnMaster("change");

			} // else already correctly set, no change
			return true;

		} // else have a non-matched freetext
		// this.log("unmatched freetext, master not set.");

		return false;
	},

	_populateFromMaster: function() {
		// this.log("populate from master select");
		// this._timingMeasure(true, "prep");
		var isEnabled = !this.selectbox.filter("[disabled]").length; //remember incoming state
		this.disable();

		this.trie = new InfixTrie(this.options.infix, this.options.caseSensitive);
		this.trie.matches = [];
		this.trie.misses = [];

		var self = this;
		var listBuilder = [];

		// this._timingMeasure(false, "prep");
		// this._timingMeasure(true, "build");

		listBuilder.push('<ul>');
		var options = this.selectbox.get(0).options;
		var thisOpt,loopCountdown,index;

		loopCountdown = options.length;
		// this.log("loopCountDown: " + loopCountdown);
		index = 0;
		while(loopCountdown--) {
			thisOpt = options[index++];
			listBuilder.push('<li name="');
			listBuilder.push(thisOpt.index);
			listBuilder.push('">');
			listBuilder.push($.trim(thisOpt.innerHTML));
			listBuilder.push('</li>');
		}

		listBuilder.push('</ul>');

		this.listScroll.html(listBuilder.join(''));
		this.list = this.listScroll.find("ul:first");

		// this._timingMeasure(false, "build");

		// this._timingMeasure(true, "kids");
		var theLiSet = this.list.get(0).getElementsByTagName('LI'); // much faster array then .childElements !
		this.listItems = $(theLiSet);

		loopCountdown = theLiSet.length;
		index = 0;
		while(loopCountdown--) {
			thisOpt = options[index];
			self.trie.add( $.trim(thisOpt.text), theLiSet[index++]); //option.text not innerHTML for trie as we dont want escaping
		}

		// this._timingMeasure(false, "kids");
		// this._timingMeasure(true, "tidy");

		this.visibleCount = theLiSet.length;
		this.setInputFromMaster();
		this.selectedLi = null;

		this.dimensioned = false;
		this.setDimensions();

		if(isEnabled) this.enable();
		// this._timingMeasure(false, "tidy");

        this._moveAttrs(this.selectbox, this.input, this.options.moveAttrs);
	},

	/*
	 * cuts and pastes all listed attributes from the source to the destination
	 */
	_moveAttrs: function(src, dest, attrs) {

        for (var i = 0; i < attrs.length; ++i) {
            var attr = attrs[i];
            var value = src.attr(attr);
            if (value) {
                dest.attr(attr, value);
                src.removeAttr(attr);
            }
        }

	},

	/*
	 * This method is called by the poller, so needs to return quickly when not dimensioning
	 */
	setDimensions: function() {
		// if a new UFD (unwrapped) and selectbox is invisible, we cant dimension
		if(!this.selectIsWrapped && !this.selectbox.filter(":visible").length) {
			return;
		}
		// if pre-exising UFD needs redimensioning, but is not visible
		if(this.selectIsWrapped && !this.wrapper.filter(":visible").length){
			return;
		}

		this.wrapper.addClass(this.css.hidden);
		if(this.selectIsWrapped && (!this.options.manualWidth || this.options.unwrapForCSS)) { // unwrap
			this.wrapper.before(this.selectbox);
			this.selectIsWrapped = false;
		}

		//match original width
		var newSelectWidth;
		if(this.options.manualWidth) {
			newSelectWidth = this.options.manualWidth;
		} else {
			newSelectWidth = this.selectbox.outerWidth();
			if (newSelectWidth < this.options.minWidth) {
				newSelectWidth = this.options.minWidth;
			} else if (this.options.maxWidth && (newSelectWidth > this.options.maxWidth) ) {
				newSelectWidth = this.options.maxWidth;
			}
		}

		var props = this.options.mimicCSS;
		for(propPtr in props){
			var prop = props[propPtr];
			if(!props.hasOwnProperty(propPtr) || typeof  prop === 'function') continue;
			this.wrapper.css(prop, this.selectbox.css(prop)); // copy property from selectbox to wrapper
		}

		if(!this.selectIsWrapped) { // wrap
			this.wrapper.get(0).appendChild(this.selectbox.get(0));
			this.selectIsWrapped = true;
		}

		this.wrapper.removeClass(this.css.hidden);
		this.listWrapper.removeClass(this.css.hidden);

		var buttonWidth = this.button.outerWidth(true);
		var wrapperBP = this.wrapper.outerWidth() - this.wrapper.width();
		var inputBP = this.input.outerWidth(true) - this.input.width();
		var listScrollBP = this.listScroll.outerWidth() - this.listScroll.width();
		var inputWidth = newSelectWidth - buttonWidth - inputBP;

		this.input.width(inputWidth);
		this.wrapper.width(newSelectWidth);

		var cssWidth = this.options.listWidthFixed ? "width" : "min-width";
		this.listWrapper.css(cssWidth, newSelectWidth + wrapperBP);
		this.listScroll.css(cssWidth, newSelectWidth + wrapperBP - listScrollBP);

/*		console.log(newSelectWidth + " : " + inputWidth + " : " +
				buttonWidth + " : " + listScrollBP + " : " + wrapperBP); */
		this.listWrapper.addClass(this.css.hidden);

		this.dimensioned = true;

	},

	setInputFromMaster: function() {
		var selectNode = this.selectbox.get(0);
		var val = "";
		try {
			val = selectNode.options[selectNode.selectedIndex].text;
		} catch(e) {
			//must have no items!BP
		}
		//this.log("setting input to: " + val);
		this.input.val(val);
	},

	revertSelected: function() {
		this.setInputFromMaster();
		this.filter(true); //show all
	},

	//corrects list wrapper's height depending on list items height
	setListDisplay: function() {

		// this._timingMeasure(true, "listDisplay");
		if(!this.itemHeight) { // caclulate only once
			this.itemHeight = this.listItems.filter("li:first").outerHeight(true);
			// this.log("listItemHeight: " + this.itemHeight);
		}
		var height;

		if (this.visibleCount > this.options.listMaxVisible) {
			height = this.options.listMaxVisible * this.itemHeight;
			this.listScroll.css(this.overflowCSS, "scroll");
		} else {
			height = this.visibleCount * this.itemHeight;
			this.listScroll.css(this.overflowCSS, "hidden");
		}

		// this.log("height set to: " + height);
		this.listScroll.height(height);
		var outerHeight = this.listScroll.outerHeight();
		this.listWrapper.height(outerHeight);

		//height set, now position

		var offset = this.wrapper.offset();
		var wrapperOuterHeight = this.wrapper.outerHeight();
		var bottomPos = offset.top + wrapperOuterHeight + outerHeight;

		var maxShown = $(window).height() + $(document).scrollTop();
		var doDropUp = (bottomPos > maxShown);


		var left = offset.left;
		var top;

		if (doDropUp) {
			this.listWrapper.addClass(this.css.listWrapperUp);
			top = (offset.top - outerHeight) ;
		} else {
			this.listWrapper.removeClass(this.css.listWrapperUp);
			top = (offset.top + wrapperOuterHeight);
		}
		this.listWrapper.css("left", left);
		this.listWrapper.css("top", top );
		this.scrollTo();

		// this._timingMeasure(false, "listDisplay");

		return height;
	},

	//returns active (hovered) element of the dropdown list
	getActive: function() {
		// this.log("get active");
		if(this.selectedLi == null) return $([]);
		return $(this.selectedLi);
	},

	//highlights the item given
	setActive: function(activeItem) {
		// this.log("setActive");
		$(this.selectedLi).removeClass(this.css.liActive);
		this.selectedLi = activeItem;
		$(this.selectedLi).addClass(this.css.liActive);
	},

	selectFirst: function() {
		// this.log("selectFirst");
		var toSelect = this.listItems.filter(":not(.invisible):first");
		this.afterSelect( toSelect );
	},

	selectLast: function() {
		// this.log("selectFirst");
		var toSelect = this.listItems.filter(":not(.invisible):last");
		this.afterSelect( toSelect );
	},


	//highlights list item before currently active item
	selectPrev: function(isPageLength) {
		// this.log("hilightprev");
		var count = isPageLength ? this.options.pageLength : 1;
		var toSelect = this.searchRelativeVisible(false, count);
		this.afterSelect( toSelect );
	},

	//highlights item of the dropdown list next to the currently active item
	selectNext: function(isPageLength) {
		// this.log("hilightnext");
		var count = isPageLength? this.options.pageLength : 1;
		var toSelect = this.searchRelativeVisible(true, count);
		this.afterSelect( toSelect );
	},

	afterSelect: function(active) {
		if(active == null) return;
		this.setActive(active);
		this.input.val(active.text());
		this.scrollTo();
		this.tryToSetMaster();
		this.inputFocus();
		this.removeEmphasis();
	},

	searchRelativeVisible: function(isSearchDown, count) {
		// this.log("searchRelative: " + isSearchDown + " : " + count);

		var active = this.getActive();
		if (!active.length) {
			this.selectFirst();
			return null;
		}

		var searchResult;

		do { // count times
			searchResult = active;
			do { //find next/prev item
				searchResult = isSearchDown ? searchResult.next() : searchResult.prev();
			} while (searchResult.length && searchResult.hasClass(this.css.hidden));

			if (searchResult.length) active = searchResult;
		} while(--count);

		return active;
	},

	//scrolls list wrapper to active: true if scroll occured
	scrollTo: function() {
		// this.log("scrollTo");
		if ("scroll" != this.listScroll.css(this.overflowCSS)) return false;
		var active = this.getActive();
		if(!active.length) return false;

		var activePos = Math.floor(active.position().top);
		var activeHeight = active.outerHeight(true);
		var listHeight = this.listWrapper.height();
		var scrollTop = this.listScroll.scrollTop();

	    /*  this.log(" AP: " + activePos + " AH: " + activeHeight +
	    		" LH: " + listHeight + " ST: " + scrollTop); */

		var top;
		var viewAheadGap = (this.options.viewAhead * activeHeight);

		if (activePos < viewAheadGap) { //  off top
			top = scrollTop + activePos - viewAheadGap;
		} else if( (activePos + activeHeight) >= (listHeight - viewAheadGap) ) { // off bottom
			top = scrollTop + activePos - listHeight + activeHeight + viewAheadGap;
		}
		else return false; // no need to scroll
		// this.log("top: " + top);
		this.listScroll.scrollTop(top);
		return true; // we did scroll.
	},

	getCurrentTextValue: function() {
		var input = $.trim(this.input.val());
		// this.log("Using input value: " + input);
		return input;
	},

	stopEvent: function(e) {
		e = e ? e : window.event;
		e.cancel = true;
		e.cancelBubble = true;
		e.returnValue = false;
		if (e.stopPropagation) {e.stopPropagation(); }
		if( e.preventDefault ) { e.preventDefault(); }
	},

	overwriteClass: function(array,  classString ) { //fast attribute OVERWRITE
		// this._timingMeasure(true, "overwriteClass");
		var tritem, index, indexB, count = 0;
		index = array.length;
		while(index--) {
			tritem = array[index];
			indexB = tritem.length;
			count += indexB;
			while(indexB--) { // duplicate match array
				tritem[indexB].setAttribute($.ui.ufd.classAttr, classString);
			}
		}
		// this._timingMeasure(false, "overwriteClass");
		return count;
	},

	listVisible: function() {
		var isVisible = !this.listWrapper.hasClass(this.css.hidden);
		// this.log("is list visible?: " + isVisible);
		return isVisible;
	},

	disable: function() {
		// this.log("disable");

		this.hideList();
		this.isDisabled = true;
		this.button.addClass(this.css.buttonDisabled);
		this.input.addClass(this.css.inputDisabled);
		this.input.attr("disabled", "disabled");
		this.selectbox.attr("disabled", "disabled");
	},

	enable: function() {
		// this.log("enable");

		this.isDisabled = false;
		this.button.removeClass(this.css.buttonDisabled);
		this.input.removeClass(this.css.inputDisabled);
		this.input.removeAttr("disabled");
		this.selectbox.removeAttr("disabled");
	},

	selectAll: function() {
		// this.log("Select All");
		this.input.get(0).select();
	},

	getDropdownContainer: function() {
		var ddc = $("#" + this.options.dropDownID);
		if(!ddc.length) { //create
			ddc = $("<div></div>")
				.appendTo("body")
				.css("height", 0)
				.attr("id", this.options.dropDownID);
		}
		return ddc;
	},

	log: function(msg) {
		if(!this.options.log) return;

		if(window.console && window.console.log) {  // firebug logger
			console.log(msg);
		}
		if( this.logNode &&  this.logNode.length) {
			this.logNode.prepend("<div>" + msg + "</div>");
		}
	},

	_calculateZIndex: function(msg) {
		var curZ, zIndex = this.options.zIndexPopup; // start here as a min

		this.selectbox.parents().each(function(){
			curZ = parseInt($(this).css("zIndex"), 10);
			if(curZ > zIndex) zIndex = curZ;
		});
		return zIndex + 1;
	},

	changeOptions: function() {
		// this.log("changeOptions");
		this._populateFromMaster();
	},

	destroy: function() {
		// this.log("called destroy");

		if(this.selectIsWrapped) { //unwrap
			this.wrapper.before(this.selectbox);
		}

        this._moveAttrs(this.input, this.selectbox, this.options.moveAttrs); // restore moved attributes
		this.labels.attr("for", this.selectbox.attr("id")); //revert label 'for' attributes.
		this.labels = null;

		this.selectbox.unbind("change." + widgetName);
		$(document).unbind("click." + widgetName, this._myDocClickHandler);
		if(this._myPollId) clearInterval(this._myPollId );
		//all other handlers are in these removed nodes.
		this.wrapper.remove();
		this.listWrapper.remove();

		if($.ui.version < "1.8") {
			// see ticket; http://dev.jqueryui.com/ticket/5005 - wasn't fixed 1.7.3
			this.selectbox.unbind("setData." + widgetName);
			this.selectbox.unbind("getData." + widgetName);
			// will remove all events sorry, might have other side effects but needed
			this.selectbox.unbind("remove");

			$.widget.prototype.destroy.apply(this, arguments); // default destroy

		} else { // 1.8+
			$.Widget.prototype.destroy.apply(this, arguments); // default destroy
		}
		this.selectbox = null;
		this._encodeDom = null;

	},


	//internal state
	dimensioned: false, // polling flag indicating that setDimensions needs to be called.
	selectIsWrapped: false,
	internalFocus: false,
	lastKey: null,
	selectedLi: null,
	isUpdatingMaster: false,
	created: false,
	hasEmphasis: false,
	isDisabled: false

});

/****************************************************************************
 * Trie + infix extension implementation for fast prefix or infix searching
 * http://en.wikipedia.org/wiki/Trie
 ****************************************************************************/

/**
 * Constructor
 */
var InfixTrie = function(isInfix, isCaseSensitive){

	this.isInfix = !!isInfix;
	this.isCaseSensitive = !!isCaseSensitive;
	this.root = [null, {}, false]; //masterNode: object, char -> trieNode map, traverseToggle
	this.infixRoots = (isInfix) ? {} : null;
};

/**
 * Add (String, Object) to store
 */
InfixTrie.prototype.add = function( key, object ) {
	key = this.cleanString(key);

	var kLen = key.length;
	var curNode = this.root;
	var chr, node;

	for(var i = 0; i < kLen; i++) {
		chr = key.charAt(i);
		node = curNode[1];
		if(chr in node) {
			curNode = node[chr];
		} else {
			curNode = node[chr] = [null, {}, this.root[2]]; // match roots' toggle setting

			if(this.isInfix) { // only add curNodes once, when created.
				if(chr in this.infixRoots) {
					this.infixRoots[chr].push(curNode);
				} else {
					this.infixRoots[chr] = [curNode];
				}
			}
		}
	}

	if(curNode[0]) curNode[0].push(object);
	else curNode[0] = [object];
	return true;
},

/**
 * Get object with two properties:
 * 	matches: array of all objects not matching entire key (String)
 * 	misses:  array of all objects exactly matching the key (String)
 *
 */
InfixTrie.prototype.find = function(key) { // string
	var trieNodeArray = this.findNodeArray(key);
	var toggleTo = !this.root[2];
	var matches = [];
	var misses = [];
	var trie;

	for(arrName in trieNodeArray){
		trie = trieNodeArray[arrName];
		if(!trieNodeArray.hasOwnProperty(arrName) || typeof trie === 'function') continue;

		this.markAndRetrieve(matches, trie, toggleTo);
	}
	this.markAndRetrieve(misses, this.root, toggleTo); //will ensure whole tree is toggled.

	return { matches : matches, misses : misses };
}

/**
 * Find array of trieNodes that match the infix key
 */
InfixTrie.prototype.findNodeArray = function(key) {
	var key = this.cleanString(key);
	var retArray = [this.root];
	var kLen = key.length;
	var chr;

	this.cache = this.cache || {};
	var thisCache = this.cache;

	for (var i = 0; i < kLen; i++) {
		chr = key.charAt(i);
		if(thisCache.chr == chr) {
			retArray = thisCache.hit;

		} else {
			retArray = this.mapNewArray(retArray, chr);
			thisCache.chr = chr;
			thisCache.hit = retArray;
			thisCache.next = {};
		}
		thisCache = thisCache.next;
	}

	return retArray;
};

/**
 * Take an array of nodes, and construct new array of children nodes along the given chr.
 */
InfixTrie.prototype.mapNewArray = function(nodeArr, chr) {

	if(nodeArr.length && nodeArr[0] == this.root) {
		if(this.isInfix) {
			return (this.infixRoots[chr] || []); // return empty array if undefined
		} else {
			var prefixRoot = this.root[1][chr];
			return (prefixRoot) ? [prefixRoot] : [];
		}
	}

	var retArray = [];
	var aLen = nodeArr.length;
	var thisNodesArray;
	for (var i = 0; i < aLen; i++) {
		thisNodesArray = nodeArr[i][1];
		if(thisNodesArray.hasOwnProperty(chr)){
			retArray.push(thisNodesArray[chr]);
		}
	}

	return retArray;
};

/**
 * retrieves objects on the given array of trieNodes.
 * Also sets toggleSet and doesnt traverse already marked branches.
 * You must call this with root to ensure complete tree is toggled.
 */
InfixTrie.prototype.markAndRetrieve = function(array, trie, toggleSet) {
	var stack = [ trie ];
	while (stack.length > 0) {
		var thisTrie = stack.pop();
		if (thisTrie[2] == toggleSet) continue; //already traversed
		thisTrie[2] = toggleSet;
		if (thisTrie[0]) array.unshift(thisTrie[0]);
		for (chr in thisTrie[1]) {
			if (thisTrie[1].hasOwnProperty(chr)) {
				stack.push(thisTrie[1][chr]);
			}
		}
	}
}

/**
 * Conform case as needed. Clean invalid characters ?
 */
InfixTrie.prototype.cleanString = function( inStr ) {
	if(!this.isCaseSensitive){
		inStr = inStr.toLowerCase();
	}
	//invalid char clean here
	return inStr;
}

/**
 * Expose for testing
 */
$.ui.ufd.getNewTrie = function(isCaseSensitive, isInfix){
	return new InfixTrie(isCaseSensitive, isInfix);
}

/* end InfixTrie */




$.extend($.ui.ufd, {
	version: "0.6",
	getter: "", //for methods that are getters, not chainables
	classAttr: (($.support.style) ? "class" : "className"),  // IE6/7 class attribute

	defaults: { // 1.7 default options location, see below
		skin: "plain", // skin name
		prefix: "ufd-", // prefix for pseudo-dropdown text input name attr.
		dropDownID: "ufd-container", // ID for a root-child node for storing dropdown lists. avoids ie6 zindex issues by being at top of tree.
		logSelector: "#log", // selector string to write log into, if present.
		mimicCSS: ["float", "tabindex", "marginLeft","marginTop","marginRight","marginBottom"], //copy these properties to widget. Width auto-copied unless min/manual.
        moveAttrs: ["tabindex", "title"], // attributes to move from select to text input


		infix: true, //infix search, not prefix
		addEmphasis: false, // add <EM> tags around matches.
		caseSensitive: false, // case sensitive search
		submitFreeText: false, // re[name] original select, give text input the selects' original [name], and allow unmatched entries
		homeEndForCursor: false, // should home/end affect dropdown or move cursor?
		allowLR: false, // show horizontal scrollbar
		calculateZIndex: false, // {max ancestor} + 1
		useUiCss: false, // use jquery UI themeroller classes.
		log: false, // log to firebug console (if available) and logSelector (if it exists)
		unwrapForCSS: false, // unwrap select on reload to get % right on units etc. unwrap causes flicker on reload in iE6
		listWidthFixed: true, // List width matches widget? If false, list can be wider to fit item width, but uses min-width so no iE6 support.

		polling: 250, // poll msec to test disabled, dimensioned state of master. 0 to disable polling, but needed for (initially) hidden fields.
		listMaxVisible: 10, // number of visible items
		minWidth: 50, // don't autosize smaller then this.
		maxWidth: null, // null, or don't autosize larger then this.
		manualWidth: null, //override selectbox width; set explicit width - stops flicker on reload in iE6 (unless unwrapForCSS) as no unwrap needed
		viewAhead: 1, // items ahead to keep in view when cursor scrolling
		pageLength: 10, // number of visible items jumped on pgup/pgdown.
		delayFilter: ($.support.style) ? 1 : 150, // msec to wait before starting filter (or get cancelled); long for IE
		delayYield: 1, // msec to yield for 2nd 1/2 of filter re-entry cancel; 1 seems adequate to achieve yield
		zIndexPopup: 101, // dropdown z-index

		// class sets
		css: {
			//skin: "plain", // if not set, will inherit options.skin
			input: "",
			inputDisabled: "disabled",
			inputFocus: "focus",

			button: "",
			buttonIcon: "icon",
			buttonDisabled: "disabled",
			buttonHover: "hover",
			buttonMouseDown: "mouseDown",

			li: "",
			liActive: "active",

			hidden: "invisible",

			wrapper: "ufd",
			listWrapper: "list-wrapper",
			listWrapperUp: "list-wrapper-up",
			listScroll: "list-scroll"
		},

		//overlaid CSS set
		uiCss: {
			skin: "uiCss",
			input: "ui-widget-content",
			inputDisabled: "disabled",

			button: "ui-button",
			buttonIcon: "ui-icon ui-icon-triangle-1-s",
			buttonDisabled: "disabled",
			buttonHover: "ui-state-focus",
			buttonMouseDown: "ui-state-active",

			li: "ui-menu-item",
			liActive: "ui-state-hover",

			hidden: "invisible",

			wrapper: "ufd ui-widget ui-widget-content",
			listWrapper: "list-wrapper ui-widget ui-widget",
			listWrapperUp: "list-wrapper-up",
			listScroll: "list-scroll ui-widget-content"
		}
	}
});

$.ui.ufd.prototype.options = $.ui.ufd.defaults; // 1.8 default options location

})(jQuery);
/* END */
