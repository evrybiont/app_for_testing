/*===========MAKE FOCUSOUT*/

Autocomplete = {};

Autocomplete.Model = function(){
  var color = $("input[data-ajax]").css("border-right-color");

  this.generateAutoBox = function($el){
    $($el).parent().append("<div id='auto_box'></div>");
    $("#auto_box").css("border", "solid 1px " + color);
    $("#auto_box").roundThis(getRadius($el));
    $("#auto_box").width($($el).outerWidth());
  }

  this.makeResponse = function($el){
    var html = result($($el).data("ajax").href);
    $("#auto_box").empty();
    $("#auto_box").append(html);
    $("#auto_box").show();
  }

  function result(href) {
    var html = parseResponse(getData(href));

    return wrap(html);
  };

  function getData(url){
    return JSON.parse($.ajax({type: 'GET',
                              url: url,
                              dataType: 'json',
                              async: false,
                              success: function(data){
                                return data;
                              }}).responseText);
  };

  function parseResponse(data){
    var attrValue, text, db, html = "";

    if (!($.isEmptyObject(data))){// ~ for mongoid
      if (data[0]["_id"]){db = 1;}}

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

  function wrap(html){return "<ul class='items'>"+ html +"</ul>"};

  function getRadius($el){
    var radius = [];

    radius.push($($el).css("border-top-left-radius"));
    radius.push($($el).css("border-top-right-radius"));
    radius.push($($el).css("border-bottom-right-radius"));
    radius.push($($el).css("border-bottom-left-radius"));

    return radius.join(' ');
  };

  $.fn.roundThis = function(radius){
    return this.each(function(e){$(this).css({"border-radius":         radius,
                                              "-moz-border-radius":    radius,
                                              "-webkit-border-radius": radius});});
  };

}

Autocomplete.Manage = function(){
  model = new Autocomplete.Model

  this.on = function(){
    if (sizeIsUntrue(this)) { return false }
    if (autoBoxIsMissing()) {model.generateAutoBox(this)}
    model.makeResponse(this);
  };

  this.out = function(){
    $("#auto_box").remove();
    $($element).val('');
  }

  function sizeIsUntrue($el){
    var size = 3;

    try {size = $($el).data("ajax").opt["size"]}
      catch(e) {}

    return ($($el).val().length <= size-1);
  };

  function autoBoxIsMissing(){return ($("#auto_box").length == 0)}
};

function initAutocompleteq(){
  manage = new Autocomplete.Manage;

  $("input[data-ajax]").keyup(manage.on);
  $("input[data-ajax]").focusout(manage.out);
}
