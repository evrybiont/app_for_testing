$(document).ready(function() {

  //TODO change element!
  function getRadius() {
    var radius = [];
    radius.push($('#user_profile_attributes_last_name').css("border-top-left-radius"));
    radius.push($('#user_profile_attributes_last_name').css("border-top-right-radius"));
    radius.push($('#user_profile_attributes_last_name').css("border-bottom-right-radius"));
    radius.push($('#user_profile_attributes_last_name').css("border-bottom-left-radius"));
    return radius.join(' ');
  };

  $.fn.roundThis = function(radius) {
    return this.each(function(e) {
      $(this).css({"border-radius":         radius,
                   "-moz-border-radius":    radius,
                   "-webkit-border-radius": radius});
    });
  };

  function parseResponse(data){
    var attrValue, text, db, html = "";

    if (data[0]["_id"]){db = 1;}  // ~ for mongoid

    $.each(data, function(){
      $.each(this, function(key, value){
        switch(db){
          case 1:
            if (value){
              if (!attrValue){attrValue = value["$oid"];}
                else {if (typeof(value) == "string"){text = value;}}}
            break;
          default:
            if (!attrValue){attrValue = value}
              else {text = value;}
        }
      });

      html += "<li value="+ attrValue +">"+ text +"</li>"
      attrValue = text = null;
    });

    return html;
  };


  function getData(url){
    return JSON.parse($.ajax({type: 'GET',
                              url: url,
                              dataType: 'json',
                              async: false,
                              success: function(data){
                                return data;    
                              }}).responseText);};

  function wrap(html){
    return "<ul class='items'>"+ html +"</ul>"
  };

  function result() {
    var html = parseResponse(getData("/hotels/find"));

    return wrap(html);
  };

  var color = $('#user_profile_attributes_last_name').css('border-right-color');

  $('input#user_profile_attributes_first_name').click(function() {
    $(this).attr('autocomplete', 'off');
    $(this).parent().append( "<div id='test' class='auto-content'></div>" );
    $('#test').css("border", "solid 1px " + color);
    var width = $('#user_profile_attributes_first_name').outerWidth();
    $('#test').roundThis(getRadius());
    $('#test').width(width);

    $('#test').append(result());
  });

  /*$('input').focusout(function() {*/
  /*$('#test').remove();*/
  /*});*/

});
