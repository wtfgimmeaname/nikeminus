jQuery.extend({
  namespace: function(s, obj, scope) {
    var arr = s.split(".");

    scope = scope || window;

    jQuery.each(arr, function(i, token) {
      scope[token] = scope[token] || {};
      scope = scope[token];
    });

    return jQuery.extend(scope, obj);
  },

  createCookie: function(name,value,days) {
    if (days) {
      var date = new Date();
      date.setTime(date.getTime()+(days*24*60*60*1000));
      var expires = "; expires="+date.toGMTString();
    } else var expires = "";
      document.cookie = name+"="+value+expires+"; path=/";
  },

  readCookie: function(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
      var c = ca[i];
      while (c.charAt(0)==' ') c = c.substring(1,c.length);
      if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
  },

  eraseCookie: function(name) { createCookie(name,"",-1); }
});
