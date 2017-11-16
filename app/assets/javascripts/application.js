// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery_nested_form
//= require_tree .

$(document).ready(function() {
  $('select').material_select();
});

$(document).ready(function() {
  Materialize.updateTextFields();
});

$(document).ready(function(){
  $('.carousel.carousel-slider').carousel({fullWidth: true, duration: 400});
  // setInterval(slide1, 5000);
  // setInterval(slide2, 5000);
});

function slide1(){
  if (!($('.carousel.carousel-slider.featured').is(":hover"))){
    $('.carousel.carousel-slider.featured').carousel('next');
  }
}

function slide2(){
  if (!($('.carousel.carousel-slider.new').is(":hover"))){
    $('.carousel.carousel-slider.new').carousel('next');
  }
}


$(document).ready(function(){
  primeCategoryData(); 
  primeGenreData(); 
  // primeUserData();
});

function primeCategoryData(){
  // category list
  $.ajax({
    type: "GET",
    dataType: "json",
    url: "/projects/categories",
    success: function(results){
      var data = {};
      for (i = 0; i < results.length; i++) { 
        data[results[i]] = null;
      }
      
      $('#project_category').autocomplete({
        data,
        limit: 20, // The max amount of results that can be shown at once. Default: Infinity.
        onAutocomplete: function(val) {
          // Callback function when value is autcompleted.
        },
        minLength: 1, // The minimum length of the input for the autocomplete to start. Default: 1.
      });
    },
    error: function (){
      window.alert("something wrong!");
    }
  });
}

function primeGenreData(){
  // category list
  $.ajax({
    type: "GET",
    dataType: "json",
    url: "/projects/genre",
    success: function(results){
      var data = {};
      for (i = 0; i < results.length; i++) { 
        data[results[i]] = null;
      }
      
      $('#project_genre').autocomplete({
        data,
        limit: 20, // The max amount of results that can be shown at once. Default: Infinity.
        onAutocomplete: function(val) {
          // Callback function when value is autcompleted.
        },
        minLength: 1, // The minimum length of the input for the autocomplete to start. Default: 1.
      });
    },
    error: function (){
      window.alert("something wrong!");
    }
  });
}

function primeUserData(){
  // category list
  $.ajax({
    type: "GET",
    dataType: "json",
    url: "/project_roles/user_names",
    success: function(results){
      var data = {};
      for (i = 0; i < results.length; i++) { 
        data[results[i]] = null;
      }
      
      $('#user_role_user').autocomplete({
        data,
        limit: 20, // The max amount of results that can be shown at once. Default: Infinity.
        onAutocomplete: function(val) {
          // Callback function when value is autcompleted.
        },
        minLength: 1, // The minimum length of the input for the autocomplete to start. Default: 1.
      });
    },
    error: function (result){
      window.alert("something wrong: users!");
      window.alert(result);
    }
  });
}

$(document).ready(function(){
	$(".queue-search").keyup(function(){
		var query = $(".queue-search").val();
		$('.search-card').hide();
		$('.search-card:contains('+query+')').show();
	});
});