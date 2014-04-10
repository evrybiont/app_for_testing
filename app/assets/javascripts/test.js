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
    var html = "";
    var attrValue = null;
    var text = null;

    $.each(data, function(){
      /*alert(JSON.stringify(this));*/
      /*alert(this._id["$oid"]);*/
      $.each(this, function(key, value){
        if (value){
          if (attrValue == null) {
            attrValue = value["$oid"];
            /*alert("attr - "+attrValue);*/
          }else{
            if (typeof(value)=="string"){
              text = value;
              /*alert("text - "+text);*/
            }
          }
        }
      });
      /*alert(attrValue+ "  -  " + text);*/
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
                              }
                            }).responseText);
  };

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
