/*
* jQuery widget to create themable Tree Lists
* 
* http://jordivila.net/code/js/jquery/ui-widgetTreeList/widgetTreeList.htm
*
*/

(function($) {
    $.widget("jv.treeList", {
        options: { selectable: true },
        _create: function() {

            var w = this;
            w._initItem($(this.element).find("li"));
            w._initChildList($(this.element).find("ul"));

            var $lisOpen = $(this.element).find("li[class*='ui-treeList-open']");
            w.openNode($lisOpen);
            w.openNode($lisOpen.parents('li'));

            $(this.element)
                .addClass('ui-treeList ui-widget ui-widget-content ui-corner-all')
                .bind('click', function(e) {
                    var $t = $(e.target);
                    if ($t.hasClass('ui-treeList-toggle')) {
                        var b = $t.siblings('ul').is(':visible');
                        if (b) w.closeNode($t.parents('li:first'));
                        else w.openNode($t.parents('li:first'));
                    }
                    if ($t.hasClass('ui-treeList-item')) {
                        w.selected($t);
                    }
                    //return false;
                })
                .disableSelection();
        },
        destroy: function() {

            $(this.element)
            .unbind('click')
            .removeClass('ui-treeList ui-widget ui-widget-content ui-corner-all')
            .find('li')
                .unbind('mouseenter mouseleave')
                .removeClass('ui-treeList-item ui-widget-content ui-corner-all ui-state-default ui-state-active ui-state-hover')
                .children('div.ui-treeList-toggle')
                    .remove()
                .end()
                .find('ul')
                    .unbind('mouseenter mouseleave')
                    .removeClass('ui-treeList-childs');

            $.Widget.prototype.destroy.call(this);
        },
        _initItem: function($lis) {
            $lis.addClass('ui-treeList-item ui-widget-content ui-corner-all ui-state-default')
                  .hover(
                        function() { $(this).addClass('ui-state-hover').parents('li').removeClass('ui-state-hover'); ; return false; }
                        , function() { $(this).removeClass('ui-state-hover'); return false; }
                    );
        },
        _initChildList: function($uls) {
            $uls.addClass('ui-treeList-childs')
                    .hide()
                    .before('<div class="ui-treeList-toggle ui-widget ui-widget-content ui-corner-all ui-icon ui-icon-plus"></div>');
        },
        openNode: function($lisOpen) {
            if ($lisOpen) {
                $lisOpen.children('ul')
                                .show()
                                .siblings('div.ui-treeList-toggle')
                                    .removeClass('ui-icon-plus')
                                    .addClass('ui-icon ui-icon-minus')
                                    .end()
                                .end()
                                .find('ul:has(li)')
                                    .parents('li')
                                        .removeClass('ui-state-default');
            }
        }
        ,
        closeNode: function($lisClose) {
            if ($lisClose) {
                $lisClose.addClass('ui-state-default')
                                .children('ul')
                                .hide()
                                .siblings('div.ui-treeList-toggle').removeClass('ui-icon-minus').addClass('ui-icon ui-icon-plus');
            }
        }
        , selected: function($lis) {
            if ($lis) {
                $(this.element).find('li').removeClass('ui-state-active');
                $lis.addClass('ui-state-active');
                this._trigger('onSelect');
            }
            else {
                return $(this.element).find('li.ui-state-active');
            }
        }
    });

})(jQuery);
