$.namespace('NikeMinus.Setup', (function() {
  function init() {
    $('.set_account').click(setupNikeMinus);
  }

  function setupNikeMinus(evt) {
    evt.preventDefault();
    var userName   = $('#userName').val();
    var nikeUserId = $('#nikeUserId').val();
    var xmlRequestUrl = "http://nikerunning.nike.com/nikeplus/v1/services/widget/get_public_run_list.jsp?userID=";
    var sendableUrl   = xmlRequestUrl+nikeUserId;
    $.ajax({
      type     : "GET",
      url      : sendableUrl,
      success  : function(xml) {
        console.log(xml);
      }
    });
  }

  return {
    init : init
  }
})());

$(document).ready(function() { NikeMinus.Setup.init(); });
