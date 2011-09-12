var dropdowns = {
  activeFilter : undefined,
  activeValue : undefined,
  events : {},
  openTime : 250,
  closeTime : 300,

  addEvent : function(id, action, timeout, fn) {
    var eventName = id + '#' + action;
    var eventId = this.events[eventName];
    if (eventId === undefined) {
      eventId = window.setTimeout(function() {
        dropdowns.removeEvent(id, action);
        fn();
      }, timeout);
      this.events[eventName] = eventId;
    }
  },

  removeEvent : function(id, action) {
    var eventName = id + "#" + action;
    var eventId = this.events[eventName];
    if (eventId != undefined) {
      window.clearTimeout(eventId);
      delete this.events[eventName];
    }
  },

  activateMenu : function(menu) {
    var id = menu.attr("id");
    this.activeFilter = id;
    this.removeEvent(id, "hide");
    this.addEvent(id, "show", this.openTime, function() {
      menu.addClass("active");
      /* IE6 kennt kein max-height. */
      var items = $('[id=' + id + '] .items');
      if (items.height() > 215)
        items.height(215);
      var allitems = $('[id=' + id + '] .allitems');
      allitems.width(220);
    });
  },

  deactivateMenu : function(menu) {
    var id = menu.attr("id");
    //console.log("deactivate " + id);
    this.removeEvent(id, "show");
    this.addEvent(id, "hide", this.closeTime, function() {
      menu.removeClass("active");
    });
  },

  activateItem : function(item) {
    this.activeValue = item.children(".urlValue").html();
    if (!this.activeValue)
      this.activeValue = item.children(".value").html();
    item.addClass("hover");
  },

  deactivateItem : function(item) {
    item.removeClass("hover");
  },

  changeFilter : function (item) {
    var query = {};
    var search = window.location.search.replace(/^\?/, "").replace(/\+/g, "%20");
    if (search != "") {
      var t1 = search.split("&");
      for (var i1 in t1) {
        var kv = t1[i1].split("=", 2);
        query[decodeURIComponent(kv[0])] = decodeURIComponent(kv[1]);
      }
    }
    if (this.activeValue == null)
      delete query[this.activeFilter];
    else
      query[this.activeFilter] = this.activeValue;
    window.location.search = $.param(query);
    //window.location.href = window.location.href;
  }

};

$(document).ready(function() {
  $('.dropdown .menu').bind('mouseover', function() { dropdowns.activateMenu($(this)); });
  $('.dropdown .menu').bind('mouseout',  function() { dropdowns.deactivateMenu($(this)); });
  $('.dropdown .item').bind('mouseover', function() { dropdowns.activateItem($(this)); });
  $('.dropdown .item').bind('mouseout',  function() { dropdowns.deactivateItem($(this)); });
  $('.dropdown .item:not(.disabled)').bind('click', function(){ dropdowns.changeFilter($(this));});
});
