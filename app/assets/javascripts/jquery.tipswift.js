// jQuery - tipSwift (MIT Licensed)
//
// Copyright (c) 2010 Victor Berchet - http://www.github.com/vicb
//
// parts of the code from:
// - tipsy, (c) 2008-2010 Jason Frame (jason@onehackoranother.com), http://github.com/jaz303/tipsy
// - swift, (c) 2009 TJ Holowaychuk <tj@vision-media.ca>, http://github.com/visionmedia/swift
//
// Version 2.1.0 - 2010-11-26

(function($) {

  function Tipswift(element) {
    this.element = element;
    this.enabled = true;
    this.shown = false;
    this.uid = 0;
  }

  $.extend(Tipswift.prototype, {
    show: function(content, options, filterContent) {
      if (!this.shown && this.enabled) {
        var ov = this.getOverlay();
        (filterContent || $.noop).call(ov);
        ov.find('.tipswift-inner').remove().end()
          .append(content.addClass('tipswift-inner'))
          .css({top: 0, left: 0, visibility: 'hidden', display: 'block'}).appendTo(document.body)
          .get(0).className = ['tipswift'].concat(options.extraClass).join(' ');
        this.setPosition(options);
        ov.addClass('tipswift-' + this.gravity);
        options.showEffect.call(ov, options, this.gravity);
        this.shown = true;
      }
      $(this.element).data('tipswift.instance', this.uid++);
    },

    hide: function(options) {
      if (this.shown && this.enabled) {
        options.hideEffect.call(this.getOverlay(), options, this.gravity);
        this.shown = false;
      }
    },

    remove: function() {
      this.getOverlay().remove();
      this.shown = false;
    },

    setPosition: function(o) {
      var ov = this.getOverlay(),
        el = this.element,
        pos = $.extend({}, $(el).offset(), { width: el.offsetWidth, height: el.offsetHeight }),
        actualWidth = ov[0].offsetWidth,
        actualHeight = ov[0].offsetHeight;

      this.gravity = $.isFunction(o.gravity) ? o.gravity.call(el) : o.gravity;

      var tp;
      switch (this.gravity.charAt(0)) {
        case 'n':
          tp = { top: pos.top + pos.height + o.offset, left: pos.left + pos.width / 2 - actualWidth / 2 };
          break;
        case 's':
          tp = { top: pos.top - actualHeight - o.offset, left: pos.left + pos.width / 2 - actualWidth / 2 };
          break;
        case 'e':
          tp = { top: pos.top + pos.height / 2 - actualHeight / 2, left: pos.left - actualWidth - o.offset };
          break;
        case 'w':
          tp = { top: pos.top + pos.height / 2 - actualHeight / 2, left: pos.left + pos.width + o.offset };
          break;
      }

      if (this.gravity.length == 2) {
        if (this.gravity.charAt(1) == 'w') {
          tp.left = pos.left + pos.width / 2 - 15;
        } else {
          tp.left = pos.left + pos.width / 2 - actualWidth + 15;
        }
      }

      ov.css(tp);
    },

    getPositionner: function(options) {
      var uid = this.uid, self = this;
      return function() {
        if (uid != $(self.element).data('tipswift.instance')) { return; }
        var ov = self.getOverlay().stop(true, true);
        self.setPosition(options);
        options.showEffect.call(ov, options, self.gravity);
        ov.stop(true, true);
      };
    },

    /**
     * Returns the overlay jQuery object (and build it when it does not exist)
     *
     * @return {jQuery}
     */
    getOverlay: function() {
      if (!this.overlay) {
        this.overlay = $('<div class="tipswift"></div>').html('<div class="tipswift-arrow"></div>');
      }
      return this.overlay;
    },

    validate: function() {
      if (!this.element.parentNode) {
        this.remove();
        this.element = null;
      }
    },

    focus : function(sel) {
      $(sel || ':input:eq(0)', this.getOverlay()).focus();
    },

    enable: function() { this.enabled = true; },

    disable: function() { this.enabled = false; },

    toggleEnabled: function() { this.enabled = !this.enabled; }
  });

  $.fn.tipSwift = function(options) {
    if (options === true) {
      return this.data('tipswift');
    } else if (typeof options == 'string') {
      var ts = this.data('tipswift');
      if (ts) { ts[options](); }
      return this;
    }
    var els = this;
    options = $.extend({}, $.tipSwift.defaultCfg, options);
    $.each(options.plugins, function() { this.init(els, options); });
    if (!options.live) { this.each(function() { $.tipSwift.get(this, options); }); }
    return this;
  };

  $.tipSwift = {
    get: function(ele, options) {
      var ts = $.data(ele, 'tipswift');
      if (!ts) {
        ts = new Tipswift(ele, $.tipSwift.elementOptions(ele));
        $.data(ele, 'tipswift', ts);
        $.each(options.plugins, function() {
          if ($.isFunction(this.initInstance)) { this.initInstance(ts); }
        });
      }
      return ts;
    },

    // Overwrite this method to provide options on a per-element basis.
    // For example, you could store the gravity in a 'tipswift-gravity' attribute:
    // return $.extend({}, options, {gravity: $(ele).attr('tipswift-gravity') || 'n' });
    // (remember - do not modify 'options' in place!)
    elementOptions : function(ele, options) {
      return $.metadata ? $.extend({}, options, $(ele).metadata()) : options;
    },

    gravity: {
      autoNS : function() {
        return $(this).offset().top > ($(document).scrollTop() + $(window).height() / 2) ? 's' : 'n';
      },

      autoWE : function() {
        return $(this).offset().left > ($(document).scrollLeft() + $(window).width() / 2) ? 'e' : 'w';
      }
    },

    effects : {
      show: function(options) {
        this.css({ visibility: 'visible', opacity: options.opacity });
      },

      hide: function() {
        this.remove();
      },

      fadeIn: function(options) {
        this.stop().css({opacity: 0, display: 'block', visibility: 'visible'}).animate({ opacity: options.opacity });
      },

      fadeOut: function() {
        this.stop().fadeOut(function() { $(this).remove(); });
      },

      slideOutWE: function(options, gravity) {
        this.stop()
          .css({visibility: 'visible', opacity: 0})
          .animate({ left: '+=' + 15 * (gravity.indexOf('e') > -1 ? -1 : 1), opacity: options.opacity });
      },

      slideInWE: function(options, gravity) {
        this.stop().animate({
            left: '-=' + 15 * (gravity.indexOf('e') > -1 ? -1 : 1),
            opacity: 0
          },
          function() { $(this).remove(); }
        );
      }
    },

    plugins: {}
  };

  $.tipSwift.defaultCfg = {
    live: false,                             // wether to use live type of event binding
    gravity: 'n',                            // tip gravity
    offset: 0,                               // offset from the element edge in pixel
    opacity: 0.9,                            // opacity [0..1]
    showEffect: $.tipSwift.effects.show,     // effect used to show the tip
    hideEffect: $.tipSwift.effects.hide,     // effect used to hide the tip (must eventually remove() the tip)
    extraClass: [],                          // extra classes to add the tip
    html: false,                             // wether to use html for the tip content
    plugins: []                              // the list of plugins
  };

  // tip plugin

  $.tipSwift.plugins.tip = function(options) {
    if (!(this instanceof arguments.callee)) {return new arguments.callee(options); }
    this.options = options || {};
  };

  $.extend($.tipSwift.plugins.tip.prototype, {
    pluginCfg: {
      showOn: ['mouseenter', 'focusin'],
      hideOn: ['mouseleave', 'focusout'],
      title: 'title',
      fallback: '',
      delayIn: 0,
      delayOut: 0,
      filterContent: $.noop
    },

    init: function (els, options) {
      var o = this.options = $.extend({}, options, this.pluginCfg, this.options);
        binder = o.live ? 'live' : 'bind';
      o.extraClass = ['tip'].concat(o.extraClass.slice(0));
      els = $(els);
      els[binder](o.showOn.join(' '), $.proxy(this.show, this));
      els[binder](o.hideOn.join(' '), $.proxy(this.hide, this));
    },

    initInstance: function(ts) {
      ts._tip = {
        showTimer: null,
        hideTimer: null
      };
    },

    fixTitle: function(el) {
      if (el.attr('title') || !el.data('tipswift.title')) {
        el.data('tipswift.title', el.attr('title') || '').removeAttr('title');
      }
    },

    show: function(e) {
      var ts = $.tipSwift.get(e.currentTarget, this.options);
      clearTimeout(ts._tip.hideTimer);
      if (this.options.delayIn) {
        this.fixTitle($(ts.element));
        var self = this;
        ts._tip.showTimer = setTimeout(function() { self.doShow(ts); }, this.options.delayIn);
      } else {
        this.doShow(ts);
      }
    },

    doShow: function(ts) {
      var o = this.options,
        el = $(ts.element),
        content;
      this.fixTitle(el);
      if (typeof o.title == 'string') {
        content = o.title == 'title' ? el.data('tipswift.title') : el.attr(o.title);
      } else if ($.isFunction(o.title)) {
        content = o.title.call(ts);
      }
      content = ('' + content).replace(/(^\s*|\s*$)/, '') || o.fallback;
      content = $('<div>')[o.html ? 'html' : 'text'](content);
      ts.show(content, o, function() { o.filterContent(content, ts.getPositionner(o), ts); });
    },

    hide: function(e) {
      var ts = $.tipSwift.get(e.currentTarget, this.options);
      clearTimeout(ts._tip.showTimer);
      if (this.options.delayOut) {
        var self = this;
        ts._tip.hideTimer = setTimeout(function() { self.doHide(ts); }, this.options.delayOut);
      } else {
        this.doHide(ts);
      }
    },

    doHide: function(ts) { ts.hide(this.options); }
  });

  // dialog plugin

  var openedDialog,
    hidingDialog = false,
    btnUid = 0,
    btnActions = {};

  $.tipSwift.templates = {};

  $.tipSwift.templates.dialog = function(parent, btnTemplate, o, ts) {
    var title = $('<span class="tipswift-title"></span>'),
      body = $('<span class="tipswift-body"></span>'),
      buttons = $('<span class="tipswift-buttons"></span>'),
      id;
    $.each(o.buttons, function (k, v) {
      id = "btn-tipswift-" + btnUid++;
      buttons.append($(btnTemplate(k, v.label, id)));
      btnActions[id] = v.action || $.noop;
    });

    if (o.body) { parent.append(body.html(o.body)); }
    parent.append(buttons).prepend(title.html(o.title));
    return function() { o.filterContent(title, body, buttons, ts.getPositionner(o), ts); };
  };

  $.tipSwift.templates.dialogButton = function(name, value, id) {
    return '<input type="button" id="' + id + '" name="' + name + '" value="' + value + '" />';
  };

  $.tipSwift.plugins.dialog = function(options) {
    if (!(this instanceof arguments.callee)) { return new arguments.callee(options); }
    this.options = options || {};
  };

  $.extend($.tipSwift.plugins.dialog.prototype, {
    pluginCfg: {
      showOn: ['click'],
      dialogTemplate: $.tipSwift.templates.dialog,        // the function used to build the dialog markup
      buttonTemplate: $.tipSwift.templates.dialogButton,  // the function used to build the buttons markup
      submitOnEnter: 0,                                   // index of the submit button used when enter is pressed (false to disable)
      filterContent: $.noop
    },

    init: function(els, options) {
      var o = this.options = $.extend({}, options, this.pluginCfg, this.options),
        binder = o.live ? 'live' : 'bind';
      o.html = true;
      o.extraClass = ['dialog'].concat(o.extraClass.slice(0));
      els = $(els);
      els[binder](o.showOn.join(' '), $.proxy(this.trigger, this));
    },

    initInstance: function (ts) {
      ts._dialog = { shown: false };
    },

    trigger: function(e) {
      e.preventDefault();
      this.show($.tipSwift.get(e.currentTarget, this.options));
    },

    show: function(ts) {
      if (ts._dialog.shown) { return; }
      if (openedDialog) { this.hide(openedDialog); }
      if (ts.shown) { ts.remove(); }
      var o = this.options,
        ov = ts.getOverlay(),
        self = this,
        dialog = $('<div>'),
        filterContent = o.dialogTemplate(dialog, o.buttonTemplate, o, ts);
      ts.show(dialog, o, filterContent);
      ts.disable();
      ts._dialog.shown = true;
      openedDialog = ts;
      ov.delegate('[id^=btn-tipswift-]', 'click',  function (e) {
        e.stopPropagation();
        e.target = ts.element;
        if (btnActions[$(this).attr('id')].call(ov, e) !== false) { self.hide(ts); }
      });
      if (o.submitOnEnter !== false) {
        ov.delegate('input, select, button', 'keydown', function (e) {
          if (e.which == 13 && !/btn-tipswift/.test($(e.currentTarget).attr('id'))) {
            ov.find('[id^=btn-tipswift-]').eq(o.submitOnEnter).click();
          }
        });
      }
      ts.focus();
    },

    hide: function(ts) {
      if (ts._dialog.shown) {
        hidingDialog = true;
        ts.enable();
        ts.hide(this.options);
        ts._dialog.shown = false;
        hidingDialog = false;
        openedDialog = null;
      }
    }
  });

})(jQuery);