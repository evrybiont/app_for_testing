ko.bindingHandlers.showStarRating = {
  init: function(element, value) {
      $(element).addClass('show-rating');
      for(var i = 0; i < value(); i++)
          $('<span>').appendTo(element);
  }
}

ko.bindingHandlers.starRating = {
    init: function(element, value) {
        $(element).addClass('star-rating');
        for(var i = 0; i < 5; i++)
            $('<span>').appendTo(element);
        $('span', element).each(function(index) {
            $(this).hover(
                function(){
                    $(this).prevAll().add(this).addClass('hover-star');
                },
                function(){
                    $(this).prevAll().add(this).removeClass('hover-star');
                }
              ).click(function(){
                  var observable = value();
                  observable(index+1);
              });
        });
    },
    update: function(element, value) {
        var observable = value();
        $("span", element).each(function(index) {
            $(this).toggleClass("chosen-star", index < observable());
        });
    }
}

var starViewModel = function() {
    this.points = ko.observable($('select').val());
};

ko.applyBindings(starViewModel);
